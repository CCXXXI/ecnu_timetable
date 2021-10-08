import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get/get.dart';

import '../utils/gu.dart';
import '../utils/loading.dart';
import 'cheater_view.dart';
import 'trivia_view.dart';

class DevLogic extends GetxController {
  void updateLog(_) => Get.snackbar('日志设置已更新', '重启后生效');

  void logOnTap() => Get.to(() => const LoggyStreamScreen());

  void triviaOnTap() => Get.to(() => const TriviaPage());

  void cheaterOnTap() => Get.to(() => const CheaterPage());

  void guOnTap() => gu();

  void loadingOnTap() => Get.defaultDialog(
        title: 'Loading',
        content: Loading(),
      );
}
