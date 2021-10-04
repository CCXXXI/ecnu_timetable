import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/logger.dart';

class ToolboxLogic extends GetxController {
  void Function() l(String url) => () => launch(url);

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

  Future<String?> _getSucker() async {
    final _r = Random().nextBool();
    try {
      final r = await Dio().get(
        _r
            ? 'https://api.vience.cn/api/tiangou'
            : 'http://api.ay15.cn/api/tiangou/api.php',
      );
      return r.data;
    } catch (e) {
      logger.e(e);
      Get.snackbar('获取舔狗语录失败', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (suckerEnabled.isTrue) updateSucker();
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
}
