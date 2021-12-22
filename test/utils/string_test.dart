import 'package:ecnu_timetable/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiver/pattern.dart';

const _num = r'(0|[1-9]\d*)';
final _semVer = RegExp('$_num\\.$_num\\.$_num');

void main() {
  group('盘古', () {
    test('空字符串仍为空', () => expect(''.s, ''));
    test('中英之间加空格', () => expect('更美观更智能的ECNU课程表'.s, '更美观更智能的 ECNU 课程表'));
    test('对已加空格的字符串重复处理无影响',
        () => expect('更美观更智能的 ECNU 课程表。'.s.s.s, '更美观更智能的 ECNU 课程表。'));
  });

  group('package info', () {
    test(
      'appName',
      () => expect(appName, 'ECNU Timetable'),
    );
    test(
      'packageName',
      () => expect(packageName, 'io.github.ccxxxi.ecnu_timetable'),
    );
    test(
      'version',
      () => expect(matchesFull(_semVer, version), isTrue),
    );
    test(
      'buildNumber',
      () => expect(matchesFull(RegExp(_num), buildNumber), isTrue),
    );
  });

  testWidgets('license', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    await initMessages();
    expect(license.startsWith('MIT License'), isTrue);
  });
}
