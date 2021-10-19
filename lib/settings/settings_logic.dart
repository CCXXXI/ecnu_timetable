import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

import '../utils/database.dart' as db;
import '../utils/log.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'theme.dart' as theme;

class SettingsLogic extends GetxController with L {
  final Dio dio;

  SettingsLogic({Dio? dio}) : dio = dio ?? defaultDio;

  void modeOnChanged(String v) {
    db.theme
      ..mode = v
      ..save();
    theme.updateTheme();
  }

  void fontOnChanged(String v) {
    db.theme
      ..font = v
      ..save();
    theme.updateTheme();
  }

  void overrideColorOnChanged(bool v) {
    db.theme
      ..overrideColor = v
      ..save();
    theme.updateTheme();
  }

  void primaryOnChanged(Color v) {
    db.theme
      ..primary = v
      ..save();
    theme.updateTheme();
  }

  void secondaryOnChanged(Color v) {
    db.theme
      ..secondary = v
      ..save();
    theme.updateTheme();
  }

  void surfaceOnChanged(Color v) {
    db.theme
      ..surface = v
      ..save();
    theme.updateTheme();
  }

  void launchPageOnChanged(String v) {
    db.misc
      ..launchPage = v
      ..save();
  }

  /// - null: loading
  /// - empty: failed
  final latestVer = Rx<String?>(null);

  @override
  void onInit() {
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

  bool get updateAvailable {
    final latest = latestVer.value;

    if (latest == null || latest.isEmpty) return false;

    final l = latest.split('.').map(int.parse);
    final v = version.split('.').map(int.parse);
    for (final pair in zip([l, v])) {
      if (pair[0] > pair[1]) return true;
    }

    return false;
  }

  /// Get latest release version from GitHub.
  Future<String?> _getLatestVer() async {
    try {
      final r = await dio.get(
        Api.releases,
        queryParameters: {'per_page': 1},
      );
      return (r.data[0]['name'] as String).substring(1);
    } catch (e) {
      l.error(e);
      Get.snackbar('获取最新版本失败', e.toString());
    }
  }

  void curVerOnTap() => Url.version(version).launch();

  void latestVerOnTap() => Url.latest.launch();

  void feedbackOnTap() => Url.issues.launch();
}
