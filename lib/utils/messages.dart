import 'package:get/get.dart';

import 'pangu.dart';

// package_info_plus 1.0.6 cannot get real info on windows
// record them manually
const appName = 'ECNU Timetable';
const packageName = 'io.github.ccxxxi.ecnu_timetable';
const version = '0.1.0';
const buildNumber = '1';

extension Messages on String {
  String get t {
    return spacingText(tr);
  }
}
