import 'dart:math';

import 'package:get/get.dart';

class JuanLogic extends GetxController {
  var _a = '';
  var _b = '';

  void aOnChanged(String s) {
    _a = s;
    r.value = _calc().toString();
  }

  void bOnChanged(String s) {
    _b = s;
    r.value = _calc().toString();
  }

  final r = null.toString().obs;

  int? _calc() {
    final a = int.tryParse(_a);
    final b = int.tryParse(_b);
    if (a != null && b != null && b > 0) {
      return a <= b ? 0 : (5 * (2 * a / b - 1) * log(a - b + 1)).ceil();
    }
  }
}
