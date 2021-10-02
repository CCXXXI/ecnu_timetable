import 'pangu.dart';

// package_info_plus cannot get real info on windows
// record them manually
const appName = 'ECNU Timetable';
const packageName = 'io.github.ccxxxi.ecnu_timetable';
const version = '0.5.0';
const buildNumber = '7';

const release = '$packageName@$version+$buildNumber';

const fontSans = 'NotoSansSC';
const fontSerif = 'NotoSerifSC';

extension PanGu on String {
  String get s => spacingText(this);
}
