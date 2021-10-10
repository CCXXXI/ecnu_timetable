import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../../utils/log.dart';

class EcnuLogic extends GetxController with L {
  /// - 0: login
  /// - 1: check
  final step = 0.obs;

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController(
    text: Settings.getValue('ecnu.id', null),
  );
  final passwordController = TextEditingController(
    text: Settings.getValue('ecnu.password', null),
  );
  final captchaController = TextEditingController();

  final checkFormKey = GlobalKey<FormState>();

  // todo: controllers

  @override
  void onClose() {
    super.onClose();
    idController.dispose();
    passwordController.dispose();
    captchaController.dispose();
  }

  String? idValidator(String? value) => value?.length == 11 ? null : '11位';

  String? passwordValidator(String? value) =>
      value?.isEmpty ?? true ? '非空' : null;

  String? captchaValidator(String? value) => value?.length == 4 ? null : '4位';

  void onStepContinue() {
    l.debug('step: ${step.value}');
    if (step.value == 0) {
      if (!loginFormKey.currentState!.validate()) return;
      // todo
      step.value++;
    } else {
      Get.back();
    }
  }
}
