import 'package:flutter/services.dart';
import 'package:loggy/loggy.dart';

import 'pangu.dart';

// package_info_plus cannot get real info on windows
// record them manually
const appName = 'ECNU Timetable';
const packageName = 'io.github.ccxxxi.ecnu_timetable';
const version = '0.8.0';
const buildNumber = '12';

const release = '$packageName@$version+$buildNumber';

const notoSans = 'NotoSansSC';
const notoSerif = 'NotoSerifSC';

extension PanGu on String {
  String get s {
    final res = spacingText(this);

    if (res != this) {
      logDebug('"$this" -> "$res"');
    } else {
      logDebug('Unnecessary spacingText: "$this"');
    }

    return res;
  }
}

late String license;

Future<void> initMessages() async =>
    license = await rootBundle.loadString('LICENSE');
