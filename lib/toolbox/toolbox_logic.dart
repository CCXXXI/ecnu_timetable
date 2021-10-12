import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../settings/settings_logic.dart';
import '../utils/log.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'calendar/calendar_logic.dart';
import 'calendar/calendar_view.dart';
import 'cheater.dart';
import 'juan/juan_view.dart';

class ToolboxLogic extends GetxController with L {
  final Dio dio;

  ToolboxLogic({Dio? dio}) : dio = dio ?? defaultDio;

  void Function() url(String url) => () => launch(url);

  @override
  void onInit() {
    super.onInit();
    if (suckerEnabled.isTrue) updateSucker();
    if (cheaterEnabled.isTrue) updateCheater();
  }

// region sucker
  final suckerEnabled = Settings.getValue('toolbox.sucker', false).obs;

  updateSuckerEnabled(bool v) {
    suckerEnabled.value = v;
    if (v) updateSucker();
  }

  final sucker = ''.obs;

  void updateSucker() async {
    sucker.value = '';
    sucker.value = await _getSucker() ?? '获取失败';
  }

  static const _suckerApis = [
    'https://api.vience.cn/api/tiangou',
    'http://api.ay15.cn/api/tiangou/api.php',
  ];

  Future<String?> _getSucker() async {
    if (GetPlatform.isWeb) return 'Web端不可用'.s;

    try {
      final r = await dio.get(randomChoice(_suckerApis));
      return (r.data as String).s;
    } catch (e) {
      l.error(e);
      Get.snackbar('获取舔狗语录失败', e.toString());
    }
  }

  void suckerOnTap() {
    Get.defaultDialog(
      title: '/sucker',
      middleText: sucker.value,
      textConfirm: '复制',
      textCancel: '刷新',
      onConfirm: () => Clipboard.setData(ClipboardData(text: sucker.value))
          .then((_) => Get.snackbar('复制成功', sucker.value)),
      onCancel: updateSucker,
    );
  }

// endregion

// region cheater
  final cheaterEnabled = Settings.getValue('toolbox.cheater', false).obs;

  updateCheaterEnabled(bool v) {
    cheaterEnabled.value = v;
    if (v) updateCheater();
  }

  final cheater = ''.obs;

  void updateCheater() {
    cheater.value = randomCheater;
  }

  void cheaterOnTap() {
    Get.defaultDialog(
      title: '/cheater',
      middleText: cheater.value,
      textConfirm: '复制',
      textCancel: '刷新',
      onConfirm: () => Clipboard.setData(ClipboardData(text: cheater.value))
          .then((_) => Get.snackbar('复制成功', cheater.value)),
      onCancel: updateCheater,
    );
  }

// endregion

// region juan
  final juanEnabled = Settings.getValue('toolbox.juan', false).obs;

  updateJuanEnabled(bool v) => juanEnabled.value = v;

  void juanOnTap() => Get.defaultDialog(
        title: 'ceil(5*(2*a/b-1)*log(a-b+1))',
        content: JuanWidget(),
      );

// endregion

  void calendarOnTap() {
    if (GetPlatform.isWeb) {
      Get.defaultDialog(
        title: 'Web端功能受限'.s,
        middleText: '因跨域资源共享（CORS）问题，无法获取并显示校历图片。',
        textConfirm: '跳转网页',
        textCancel: '下载完整版',
        onConfirm: url(CalendarLogic.url),
        onCancel: url(SettingsLogic.latestUrl),
      );
    } else {
      Get.to(() => CalendarPage());
    }
  }
}
