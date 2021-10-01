import 'package:ecnu_timetable/utils/messages.dart';
import 'package:flutter_test/flutter_test.dart';

const _num = r'(0|[1-9]\d*)';
final _semVer = RegExp('^$_num\\.$_num\\.$_num\$');

Future<void> main() async {
  group('盘古', () {
    test('空字符串仍为空', () => expect(''.t, ''));
    test('中英之间加空格', () => expect('更美观更智能的ECNU课程表。'.t, '更美观更智能的 ECNU 课程表。'));
    test('对已加空格的字符串重复处理无影响',
        () => expect('更美观更智能的 ECNU 课程表。'.t.t.t, '更美观更智能的 ECNU 课程表。'));
  });

  group('package info', () {
    test('appName', () => expect(appName, 'ECNU Timetable'));
    test('packageName',
        () => expect(packageName, 'io.github.ccxxxi.ecnu_timetable'));
    test('version', () => expect(_semVer.hasMatch(version), isTrue));
    test('buildNumber',
        () => expect(RegExp('^$_num\$').hasMatch(buildNumber), isTrue));
  });
}
