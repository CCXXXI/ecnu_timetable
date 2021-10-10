import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../../utils/dio.dart';
import '../../utils/log.dart';

class EcnuLogic extends GetxController with L {
  /// - 0: login
  /// - 1: check
  final step = 0.obs;

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController(
    text: Settings.getValue('ecnu.id', null),
  );
  final passwordController = TextEditingController(
    text: Settings.getValue('ecnu.password', null),
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

  String? idValidator(String? value) => value?.length == 11 ? null : '11位';

  String? passwordValidator(String? value) =>
      value?.isEmpty ?? true ? '非空' : null;

  String? captchaValidator(String? value) => value?.length == 4 ? null : '4位';

  final isLoading = true.obs;

  void onStepContinue() async {
    l.debug('step: ${step.value}, isLoading: ${isLoading.value}');
    if (isLoading.isTrue || !loginFormKey.currentState!.validate()) return;

    if (step.value == 0) {
      isLoading.value = true;
      if (await login()) step.value++;
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
      await dio.get(_Url.portal);
      l.debug(await cookieJar.loadForRequest(Uri.parse(_Url.portal)));

      // get captcha image
      final img = await dio.get(
        _Url.captcha,
        options: Options(responseType: ResponseType.bytes),
      );
      captchaImage.value = img.data;

      // get captcha value
      final token = (await dio.get(
        'https://aip.baidubce.com/oauth/2.0/token',
        queryParameters: {
          'grant_type': 'client_credentials',
          'client_id': r'gIGpKT20OzkxymfIGH5L8pho',
          'client_secret': r'9O1EO7CuixZqF0oBxYZbKmeCuqHoRlMk',
        },
      ))
          .data['access_token'];
      final value = (await dio.post(
        'https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic',
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

  Future<bool> login() async {
    l.debug('login begin');
    await Future.delayed(const Duration(seconds: 3));
    l.debug('login end');
    return true;
  }
}

class _Url {
  static const _cas = 'https://portal1.ecnu.edu.cn/cas';
  static const _eams = 'https://applicationnewjw.ecnu.edu.cn/eams';

  static const portal =
      '$_cas/login?service=https://portal2020-api.ecnu.edu.cn/api/v1/idc/slo';
  static const captcha = '$_cas/code';
  static const ids = '$_eams/courseTableForStd!index.action';
  static const table = '$_eams/courseTableForStd!courseTable.action';
}
