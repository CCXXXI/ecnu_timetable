import 'package:ecnu_timetable/messages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('盘古', () {
    test('空字符串仍为空', () => expect(''.tr, ''));
    test('中英之间加空格', () => expect('更美观更智能的ECNU课程表。'.tr, '更美观更智能的 ECNU 课程表。'));
    test('对已加空格的字符串重复处理无影响',
        () => expect('更美观更智能的 ECNU 课程表。'.tr.tr.tr, '更美观更智能的 ECNU 课程表。'));
  });
}
