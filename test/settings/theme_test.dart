import 'package:ecnu_timetable/settings/theme.dart';
import 'package:ecnu_timetable/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
    await initDatabase(clear: true);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('theme', () => expect(appTheme.colorScheme.onPrimary, Colors.white));
}
