import 'package:get/get.dart';
import 'package:pangu/pangu.dart';

var _pangu = Pangu().spacingText;

extension PanGu on String {
  String get tr {
    return _pangu(Trans(this).tr);
  }
}
