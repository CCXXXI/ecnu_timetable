import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/settings_logic.dart';
import '../../utils/gu.dart';
import '../../utils/messages.dart';
import '../ecnu/ecnu_view.dart';

class TimetableMenuLogic extends GetxController {
  void ecnuOnTap() {
    if (GetPlatform.isWeb) {
      Get.defaultDialog(
        title: 'Web端功能受限'.s,
        middleText: '因跨域资源共享（CORS）问题，无法连接公共数据库。',
        textConfirm: '下载完整版',
        textCancel: '返回',
        onConfirm: () => launch(SettingsLogic.latestUrl),
      );
    } else {
      Get.to(() => EcnuPage());
    }
  }

  void htmlOnTap() => gu();
}
