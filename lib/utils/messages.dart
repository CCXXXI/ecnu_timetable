import 'package:get/get.dart';

import 'pangu.dart';

extension Messages on String {
  String get t {
    return spacingText(tr);
  }
}
