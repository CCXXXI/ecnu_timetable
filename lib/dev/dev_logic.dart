import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get/get.dart';

import '../toolbox/toolbox_logic.dart';
import '../utils/database.dart';
import '../utils/gu.dart';
import '../utils/loading.dart';
import '../utils/log.dart';
import 'cheater_view.dart';
import 'trivia_view.dart';

class DevLogic extends GetxController with L {
  final toolboxLogic = Get.find<ToolboxLogic>();

  void suckerOnChanged(bool v) {
    toolbox
      ..sucker = v
      ..save();
    toolboxLogic.updateSuckerEnabled(v);
  }

  void cheaterOnChanged(bool v) {
    toolbox
      ..cheater = v
      ..save();
    toolboxLogic.updateCheaterEnabled(v);
  }

  void juanOnChanged(bool v) {
    toolbox
      ..juan = v
      ..save();
    toolboxLogic.updateJuanEnabled(v);
  }

  void levelOnChanged(String v) {
    log
      ..level = v
      ..save();
    Get.snackbar('日志设置已更新', '重启后生效');
  }

  void stackTraceLevelOnChanged(String v) {
    log
      ..stackTraceLevel = v
      ..save();
    Get.snackbar('日志设置已更新', '重启后生效');
  }

  void includeCallerInfoOnChanged(bool v) {
    log
      ..includeCallerInfo = v
      ..save();
    Get.snackbar('日志设置已更新', '重启后生效');
  }

  void logOnTap() => Get.to(() => const LoggyStreamScreen());

  void triviaOnTap() => Get.to(() => const TriviaPage());

  void cheaterOnTap() => Get.to(() => const CheaterPage());

  void guOnTap() => gu();

  void loadingOnTap() => Get.defaultDialog(
        title: 'Loading',
        content: Loading(),
      );
}
