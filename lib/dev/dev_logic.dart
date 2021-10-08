import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/gu.dart';
import '../utils/loading.dart';
import '../utils/log.dart';
import 'cheater_view.dart';
import 'trivia_view.dart';

class DevLogic extends GetxController with L {
  void updateLog(_) => Get.snackbar('日志设置已更新', '重启后生效');

  void logOnTap() => Get.to(() => const LoggyStreamScreen());

  void triviaOnTap() => Get.to(() => const TriviaPage());

  void cheaterOnTap() => Get.to(() => const CheaterPage());

  void guOnTap() => gu();

  void loadingOnTap() => Get.defaultDialog(
        title: 'Loading',
        content: Loading(),
      );

  final jsonFile = ''.obs;

  @override
  void onInit() async {
    if (GetPlatform.isDesktop && !GetPlatform.isWeb) {
      final baseDir = (await getApplicationSupportDirectory()).path;
      l.info(jsonFile.value = '$baseDir\\shared_preferences.json');
    }
    super.onInit();
  }

  void jsonOnTap() async {
    l.info((await OpenFile.open(jsonFile.value)).message);
  }
}
