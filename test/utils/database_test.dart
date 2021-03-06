import 'package:ecnu_timetable/utils/database.dart';
import 'package:ecnu_timetable/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  setUpAll(() async {
    // This is safe because [getApplicationSupportDirectory]
    // will return a test directory in the test environment.
    await initDatabase(
      clear: true,
      forceDefaultInit: true,
    );
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('user', () async {
    expect(user.id, isNull);
    user.id = '10101001000';
    await user.save();
    expect(user.id, '10101001000');
  });

  test('log', () {
    expect(LogLevel.values.contains(log.level_), isTrue);
    expect(LogLevel.values.contains(log.stackTraceLevel_), isTrue);
    expect(log.levels, LogLevel.values.map((e) => e.name));
  });

  test('toolbox', () {
    expect(toolbox.order[0], 0);
    expect(toolbox.order[1], 1);
    expect(toolbox.order[2], 2);

    toolbox.reorder(0, 2);
    expect(toolbox.order[0], 1);
    expect(toolbox.order[1], 0);
    expect(toolbox.order[2], 2);

    toolbox.reorder(1, 0);
    expect(toolbox.order[0], 0);
    expect(toolbox.order[1], 1);
    expect(toolbox.order[2], 2);
  });

  test('misc', () {
    expect(misc.launchPage_, 1);
    expect(misc.pages.length, 3);
  });

  test('theme', () async {
    expect(theme.mode_, ThemeMode.system);
    expect(theme.modes.length, 3);

    expect(theme.fonts, isNotEmpty);
    expect(theme.applyFont(Typography().black).headline2!.fontFamily, notoSans);

    expect(theme.onPrimary, Colors.white);
    expect(theme.onSecondary, Colors.white);
    expect(theme.onSurface, Colors.white);

    theme
      ..primary = Colors.white
      ..secondary = Colors.white
      ..surface = Colors.white
      ..overrideColor = true;
    expect(theme.onPrimary, Colors.black);
    expect(theme.onSecondary, Colors.black);
    expect(theme.onSurface, Colors.black);
  });

  test('reflexive', () {
    expect(UserAdapter(), UserAdapter());
    expect(LogAdapter(), LogAdapter());
    expect(ToolboxAdapter(), ToolboxAdapter());
    expect(MiscAdapter(), MiscAdapter());
    expect(ThemeAdapter(), ThemeAdapter());
    expect(CourseAdapter(), CourseAdapter());
    expect(PeriodAdapter(), PeriodAdapter());

    expect(UserAdapter().hashCode, UserAdapter().hashCode);
    expect(LogAdapter().hashCode, LogAdapter().hashCode);
    expect(ToolboxAdapter().hashCode, ToolboxAdapter().hashCode);
    expect(MiscAdapter().hashCode, MiscAdapter().hashCode);
    expect(ThemeAdapter().hashCode, ThemeAdapter().hashCode);
    expect(CourseAdapter().hashCode, CourseAdapter().hashCode);
    expect(PeriodAdapter().hashCode, PeriodAdapter().hashCode);
  });
}
