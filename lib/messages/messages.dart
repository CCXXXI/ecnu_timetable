import 'package:get/get.dart';

import 'pangu.dart';

var _pangu = Pangu().spacingText;

extension PanGu on String {
  String get tr {
    return _pangu(Trans(this).tr);
  }
}
