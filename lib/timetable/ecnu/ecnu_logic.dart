import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_html/parsing.dart';

import '../../utils/log.dart';
import '../../utils/web.dart';
import 'des.dart';

enum S { login, check }

class EcnuLogic extends GetxController with L {
  final Dio dio;

  EcnuLogic({Dio? dio}) : dio = dio ?? defaultDio;

  final step = S.login.obs;

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController(
    text: Settings.getValue('ecnu.id', ''),
  );
  final passwordController = TextEditingController(
    text: Settings.getValue('ecnu.password', ''),
  );
  final captchaController = Rx<TextEditingController?>(null);

  final checkFormKey = GlobalKey<FormState>();

  // todo: controllers

  @override
  void onClose() {
    super.onClose();
    idController.dispose();
    passwordController.dispose();
    captchaController.value?.dispose();
  }

  static String? idValidator(String? value) =>
      value?.length == 11 ? null : '11位';

  static String? passwordValidator(String? value) =>
      value?.isEmpty ?? true ? '非空' : null;

  static String? captchaValidator(String? value) =>
      value?.length == 4 ? null : '4位';

  final isLoading = true.obs;

  void onStepContinue() async {
    l.debug('step: ${step.value}, isLoading: ${isLoading.value}');
    if (isLoading.isTrue ||
        step.value == S.login && !loginFormKey.currentState!.validate()) return;

    if (step.value == S.login) {
      isLoading.value = true;
      try {
        final loginResult = await login();
        if (loginResult == null) {
          step.value = S.check;
          getTable();
        } else {
          Get.back();
          Get.snackbar('登录失败', loginResult);
        }
      } catch (e) {
        l.error(e);
        Get.back();
        Get.snackbar('登录失败', e.toString());
      }
    } else {
      Get.back();
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    initEcnu();
  }

  final captchaImage = Rx<Uint8List>(Uint8List.fromList([]));

  void initEcnu() async {
    try {
      // set cookie
      await dio.get(Url.portal);
      l.debug(await cookieJar.loadForRequest(Uri.parse(Url.portal)));

      // get captcha image
      final img = await dio.get(
        Url.captcha,
        options: Options(responseType: ResponseType.bytes),
      );
      captchaImage.value = img.data;

      // get captcha value
      final token = (await dio.get(
        Api.baiduToken,
        queryParameters: {
          'grant_type': 'client_credentials',
          'client_id': 'gIGpKT20OzkxymfIGH5L8pho',
          'client_secret': '9O1EO7CuixZqF0oBxYZbKmeCuqHoRlMk',
        },
      ))
          .data['access_token'];
      final value = (await dio.post(
        Api.baiduOcr,
        queryParameters: {
          'access_token': token,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'image': base64Encode(img.data),
        },
      ))
          .data['words_result'][0]['words'];
      captchaController.value = TextEditingController(text: value);

      isLoading.value = false;
    } catch (e) {
      l.error(e);
      Get.back();
      Get.snackbar('连接公共数据库失败', e.toString());
    }
  }

  /// Returns null if success.
  Future<String?> login() async {
    final id = idController.text;
    final password = passwordController.text;
    final captcha = captchaController.value!.text;
    l.debug('id: $id, password: $password, captcha: $captcha');

    var r = await dio.post(
      Url.portal,
      data: {
        'rsa': strEnc(id + password),
        'ul': id.length,
        'pl': password.length,
        'code': captcha,
        'lt': 'LT-211100-OG7kcGcBAxSpyGub3FC9LU6BtINhGg-cas',
        'execution': 'e1s1',
        '_eventId': 'submit',
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        validateStatus: (status) => status != null && status < 400,
      ),
    );
    while ([301, 302].contains(r.statusCode)) {
      // 按规范来说post请求不应该返回302进行重定向
      // 但是这个世界并不是很规范
      // 手动处理一下这串连环重定向
      // 不能直接让dio处理，dio（或者说底层的http）太规范了，在重定向过程中不会更新cookie
      l.info('redirect');
      r = await dio.get(
        r.headers['location']![0],
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status != null && status < 400,
        ),
      );
    }

    final document = parseHtmlDocument(r.data);

    final nameId = document.querySelector('a[title="查看登录记录"]')?.text;
    if (nameId != null) {
      final m = RegExp(r'(.*)\((.*)\)').firstMatch(nameId);
      final name = m!.group(1);
      final id_ = m.group(2);
      assert(id_ == id);

      Settings.setValue('ecnu.id', id);
      Settings.setValue('ecnu.name', name);
      Settings.setValue('ecnu.password', password);
      Sentry.configureScope((scope) => scope.user =
          SentryUser(id: id, username: name, ipAddress: '{{auto}}'));

      return null;
    }

    final error = document.querySelector('#errormsg')?.text;
    if (error != null) return error;

    return '未知错误';
  }

  final table = ''.obs;

  void getTable() async {
    final r0 = await dio.get(Url.ids);
    final ids = RegExp(r'bg\.form\.addInput\(form,"ids","(\d+)"\);')
        .firstMatch(r0.data)!
        .group(1)!;

    final r1 = await dio.post(
      Url.table,
      data: {
        // todo: let user determines these options
        'ignoreHead': 1,
        'setting.kind': 'std',
        'startWeek': 1,
        'semester.id': semId(2021, 0),
        'ids': ids,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    final document = parseHtmlDocument(r1.data);
    final js = document.querySelectorAll('script[language]').last.text;
    parseJs(js!);
    table.value = r1.data;
  }

  /// 2018-2019学年度上学期为705，每向前/向后一个学期就增加/减少32
  static int semId(int year, int sem) => 705 + (year - 2018) * 96 + sem * 32;

  static void parseJs(String js) {
    // todo
  }
}
