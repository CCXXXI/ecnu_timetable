import 'package:ecnu_timetable/utils/database.dart';
import 'package:ecnu_timetable/utils/log.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testMessage = 'Lorem ipsum dolor sit';

class LogTest with L {
  void test() => loggy.debug(testMessage);
}

void main() async {
  setUpAll(() async {
    await initDatabase();
    initLog();
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('loggy', () => expect(LogTest().test, throwsUnsupportedError));
}
