import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get/get.dart';

import 'trivia_view.dart';

class DevLogic extends GetxController {
  void triviaOnTap() => Get.to(() => const TriviaPage());

  void updateLog(_) => Get.snackbar('日志设置已更新', '重启后生效');

  void logOnTap() => Get.to(() => const LoggyStreamScreen());
}
