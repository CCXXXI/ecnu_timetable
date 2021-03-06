import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/log.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'calendar/calendar_view.dart';
import 'cheater.dart';
import 'juan/juan_view.dart';

class ToolboxLogic extends GetxController with L {
  @override
  void onInit() {
    super.onInit();
    updateSucker();
    updateCheater();
  }

// region sucker
  final sucker = ''.obs;

  void updateSucker() async {
    sucker.value = '';
    sucker.value = await _getSucker() ?? '获取失败';
  }

  Future<String?> _getSucker() async {
    if (GetPlatform.isWeb) return 'Web端不可用'.s;

    try {
      final r = await dio.get(Api.randomSucker);
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

  void juanOnTap() => Get.defaultDialog(
        title: 'ceil(5*(2*a/b-1)*log(a-b+1))',
        content: JuanWidget(),
      );

  void calendarOnTap() {
    if (GetPlatform.isWeb) {
      Get.defaultDialog(
        title: 'Web端功能受限'.s,
        middleText: '因跨域资源共享（CORS）问题，无法获取并显示校历图片。',
        textConfirm: '跳转网页',
        textCancel: '下载完整版',
        onConfirm: Url.calendar.launch,
        onCancel: Url.latest.launch,
      );
    } else {
      Get.to(() => CalendarPage());
    }
  }
}
