import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../utils/log.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'theme.dart' as theme;

class SettingsLogic extends GetxController with L {
  final Dio dio;

  SettingsLogic({Dio? dio}) : dio = dio ?? defaultDio;

  void updateTheme(_) => theme.updateTheme();

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
    final ver = latestVer.value;
    return ver != null && ver.isNotEmpty && ver != version;
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
