import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JuanLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  final controllerA = TextEditingController();
  final controllerB = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    controllerA.dispose();
    controllerB.dispose();
  }

  final r = 0.obs;

  void updateR() {
    if (!formKey.currentState!.validate()) return;

    final a = int.parse(controllerA.text);
    final b = int.parse(controllerB.text);
    r.value = a <= b ? 0 : (5 * (2 * a / b - 1) * log(a - b + 1)).ceil();
  }

  String? validatorA(String? value) =>
      int.tryParse(value ?? '') == null ? 'invalid' : null;

  String? validatorB(String? value) =>
      [null, 0].contains(int.tryParse(value ?? '')) ? 'invalid' : null;
}
