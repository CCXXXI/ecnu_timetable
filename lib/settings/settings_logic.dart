import 'package:dio/dio.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/gu.dart';
import '../utils/logger.dart';
import '../utils/messages.dart';
import 'theme.dart' as theme;

class SettingsLogic extends GetxController {
  bool get loggedIn => id != null;

  String? get id => Settings.getValue('id', null);

  String? get username => Settings.getValue('username', null);

  void login() => gu(); // todo

  void updateTheme(_) => theme.updateTheme();

  /// - null: loading
  /// - empty: failed
  final latestVer = Rx<String?>(null);

  @override
  void onInit() async {
    super.onInit();
    updateVerInfo();
  }

  void updateVerInfo() async {
    latestVer.value = null;
    latestVer.value = await _getLatestVer() ?? '';
    if (updateAvailable) {
      Get.snackbar('发现新版本', '$version → ${latestVer.value}');
    }
  }

  bool get updateAvailable =>
      latestVer.value != null && latestVer.value != version;

  /// Get latest release version from GitHub.
  Future<String?> _getLatestVer() async {
    try {
      final r = await Dio().get(
        'https://api.github.com/repos/ccxxxi/ecnu_timetable/releases',
        queryParameters: {'per_page': 1},
      );
      return (r.data[0]['name'] as String).substring(1);
    } catch (e) {
      logger.e(e);
      Get.snackbar('获取最新版本失败', e.toString());
    }
  }

  static String _getVerUrl(String v) =>
      'https://github.com/CCXXXI/ecnu_timetable/releases/tag/v$v';

  void curVerOnTap() async => await launch(_getVerUrl(version));

  void latestVerOnTap() async =>
      await launch('https://github.com/CCXXXI/ecnu_timetable/releases/latest');

  void feedbackOnTap() async =>
      await launch('https://github.com/CCXXXI/ecnu_timetable/issues');
}
