import 'package:ecnu_timetable/utils/log.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loggy/loggy.dart';

const testMessage = 'Lorem ipsum dolor sit';

class LogTest with L {
  void test() => loggy.debug(testMessage);
}

void main() async {
  initLog(
    level: LogLevel.all,
    stackTraceLevel: LogLevel.off,
    includeCallerInfo: false,
  );

  test('loggy', () => expect(LogTest().test, throwsUnsupportedError));
}
