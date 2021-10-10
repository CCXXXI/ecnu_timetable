import 'package:get/get.dart';

import '../../utils/log.dart';

class EcnuLogic extends GetxController with L {
  /// - 0: login
  /// - 1: check
  final step = 0.obs;

  void onStepContinue() {
    l.debug('step: ${step.value}');
    if (step.value == 0) {
      // todo
      step.value++;
    } else {
      Get.back();
    }
  }
}
