import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/parsing.dart';

import '../../utils/database.dart';
import '../../utils/log.dart';
import '../../utils/web.dart';
import 'des.dart';

enum S { login, check }

class EcnuLogic extends GetxController with L {
  final Dio dio;

  EcnuLogic({Dio? dio}) : dio = dio ?? defaultDio;

  final step = S.login.obs;

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController(text: user.id);
  final passwordController = TextEditingController(text: user.password);
  final captchaController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    idController.dispose();
    passwordController.dispose();
    captchaController.dispose();
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
      try {
        final loginResult = await login();
        if (loginResult == null) {
          step.value = S.check;
          getTimetable();
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
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initEcnu();
  }

  final captchaImage = Rx<Uint8List>(Uint8List.fromList([]));
  final captchaReady = false.obs;

  void initEcnu() async {
    try {
      // set cookie
      await cookieJar.deleteAll();
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
      captchaController.text = value;
      captchaReady.value = true;

      isLoading.value = false;
    } catch (e) {
      l.error(e);
      Get.back();
      Get.snackbar('连接公共数据库失败', e.toString());
    }
  }

  /// Returns null if success.
  Future<String?> login() async {
    isLoading.value = true;

    final id = idController.text;
    final password = passwordController.text;
    final captcha = captchaController.text;
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

      user
        ..id = id
        ..name = name
        ..password = password
        ..save();

      return null;
    }

    final error = document.querySelector('#errormsg')?.text;
    if (error != null) return error;

    return '未知错误';
  }

  final year = guessYear(DateTime.now()).obs;
  final semester = guessSemester(DateTime.now()).obs;
  final coursesPreview = ''.obs;

  static int guessYear(DateTime date) =>
      date.month >= 8 ? date.year : date.year - 1;

  static int guessSemester(DateTime date) => date.month >= 8 || date.month <= 1
      ? 0
      : date.month == 7
          ? 2
          : 1;

  Map<int, String> get years => {
        for (var y = year.value - 2; y <= year.value + 2; y++)
          y: '$y - ${y + 1}',
      };

  final semesters = {
    0: '第一学期',
    1: '第二学期',
    2: '暑期学期',
  };

  void yearOnChanged(int value) {
    year.value = value;
    getTimetable();
  }

  void semesterOnChanged(int value) {
    semester.value = value;
    getTimetable();
  }

  void getTimetable() async {
    isLoading.value = true;

    try {
      final r0 = await dio.get(Url.ids);
      final ids = getIds(r0.data);

      final r1 = await dio.post(
        Url.table,
        data: {
          'ignoreHead': 1,
          'setting.kind': 'std',
          'startWeek': 1,
          'semester.id': semesterId(year.value, semester.value),
          'ids': ids,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      final document = parseHtmlDocument(r1.data);
      final coursesJs = document.querySelectorAll('script[language]').last.text;

      await courses.clear();
      await courses.addAll(getCourses(coursesJs!));
      coursesPreview.value =
          courses.values.map((e) => e.courseName).toSet().join('\n');
    } catch (e) {
      coursesPreview.value = '获取失败';
    }

    isLoading.value = false;
  }

  static String getIds(String data) =>
      RegExp(r'bg\.form\.addInput\(form,"ids","(.*)"\);')
          .firstMatch(data)!
          .group(1)!;

  /// 2018-2019学年度上学期为705，每向前/向后一个学期就增加/减少32
  static int semesterId(int year, int semester) =>
      705 + (year - 2018) * 96 + semester * 32;

  static List<Course> getCourses(String coursesJs) {
    final newCourse = RegExp('TaskActivity'
        r'\('
        '"(?<teacherId>.*)",'
        '"(?<teacherName>.*)",'
        r'"(?<courseId>.*)\((?<courseCode>.*)\.(?<courseNo>.*)\)",'
        r'"(?<courseName>.*)\((?<courseCode2>.*)\.(?<courseNo2>.*)\)",'
        '"(?<roomId>.*)",'
        '"(?<roomName>.*)",'
        '"(?<weeks>[01]{53})",'
        '(?<taskId>null),'
        '"(?<expLessonGroupId>.*)",'
        '"(?<expLessonGroupIndexNo>.*)",'
        '"(?<remark>.*)",'
        '"(?<specialRoom>.*)"'
        r'\)');
    final period = RegExp(r'(?<weekday>\d+)\*unitCount\+(?<unit>\d+)');

    final courseBuffer = <Course>[];

    for (final line in coursesJs.split(';')) {
      final n = newCourse.firstMatch(line);
      if (n != null) {
        assert(n.namedGroup('courseCode') == n.namedGroup('courseCode2'));
        assert(n.namedGroup('courseNo') == n.namedGroup('courseNo2'));

        courseBuffer.add(
          Course()
            ..teacherId = n.namedGroup('teacherId')
            ..teacherName = n.namedGroup('teacherName')
            ..courseId = n.namedGroup('courseId')
            ..courseCode = n.namedGroup('courseCode')
            ..courseNo = n.namedGroup('courseNo')
            ..courseName = n.namedGroup('courseName')
            ..roomId = n.namedGroup('roomId')
            ..roomName = n.namedGroup('roomName')
            ..weeks = n
                .namedGroup('weeks')
                ?.codeUnits
                .map((e) => e == '1'.codeUnits.first)
                .toList(growable: false)
            ..taskId = null
            ..expLessonGroupId = n.namedGroup('expLessonGroupId')
            ..expLessonGroupIndexNo = n.namedGroup('expLessonGroupIndexNo')
            ..remark = n.namedGroup('remark')
            ..specialRoom = n.namedGroup('specialRoom')
            ..periods = [],
        );

        continue;
      }

      final p = period.firstMatch(line);
      if (p != null) {
        courseBuffer.last.periods!.add(
          Period()
            ..weekday = int.parse(p.namedGroup('weekday')!)
            ..unit = int.parse(p.namedGroup('unit')!),
        );
      }
    }

    return courseBuffer;
  }
}
