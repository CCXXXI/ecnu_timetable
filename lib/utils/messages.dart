import 'pangu.dart';

// package_info_plus 1.0.6 cannot get real info on windows
// record them manually
const appName = 'ECNU Timetable';
const packageName = 'io.github.ccxxxi.ecnu_timetable';
const version = '0.3.1';
const buildNumber = '5';

const release = '$packageName@$version+$buildNumber';

extension Messages on String {
  String get s {
    return spacingText(this);
  }
}
