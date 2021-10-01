import 'dart:math';

import 'package:get/get.dart';

final _random = Random();

String _r(int i) => '🕊' * _random.nextInt((Get.width / i - 1).floor());

void gu() {
  Get.snackbar(_r(24), _r(20));
}
