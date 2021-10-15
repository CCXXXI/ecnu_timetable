import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JuanLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  final aController = TextEditingController();
  final bController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    aController.dispose();
    bController.dispose();
  }

  String? aValidator(String? value) =>
      int.tryParse(value ?? '') == null ? 'invalid' : null;

  String? bValidator(String? value) =>
      [null, 0].contains(int.tryParse(value ?? '')) ? 'invalid' : null;

  final r = 0.obs;

  void updateR() {
    if (!formKey.currentState!.validate()) return;

    final a = int.parse(aController.text);
    final b = int.parse(bController.text);
    r.value = a <= b ? 0 : (5 * (2 * a / b - 1) * log(a - b + 1)).ceil();
  }
}
