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

  final isLoading = false.obs;

  void onStepContinue() async {
    l.debug('step: ${step.value}, isLoading: ${isLoading.value}');
    if (isLoading.isTrue || !loginFormKey.currentState!.validate()) return;

    if (step.value == 0) {
      isLoading.value = true;
      if (await login()) step.value++;
    } else {
      Get.back();
    }

    isLoading.value = false;
  }

  Future<bool> login() async {
    l.debug('login begin');
    await Future.delayed(const Duration(seconds: 3));
    l.debug('login end');
    return true;
  }
}
