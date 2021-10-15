import 'package:ecnu_timetable/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

const testMessage = 'Lorem ipsum dolor sit';

class LogTest with L {
  void testLoggy() => loggy.debug(testMessage);

  void testL() => l.debug(testMessage);
}

void main() async {
  testWidgets(
    'loggy',
    (tester) async {
      await Settings.init();
      initLog(level: LogLevel.all);
      final logTest = LogTest();

      expect(logTest.testLoggy, throwsUnsupportedError);

      await tester.pumpWidget(
        const MaterialApp(
          home: LoggyStreamScreen(),
        ),
      );

      for (int i = 0; i != 3; ++i) {
        await tester.pumpAndSettle();
        expect(find.text(testMessage), findsNWidgets(i));
        logTest.testL();
      }
    },
    // Some tests are endless on GitHub Actions. Skip them.
    skip: GetPlatform.isLinux,
  );
}
