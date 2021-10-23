import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

import '../utils/database.dart';
import 'timetable_menu/timetable_menu_view.dart';

class TimetableLogic extends GetxController {
  static void openMenu() => Get.to(() => TimetableMenuPage());

  static List<List<List<Course>>> get weekdayUnit {
    final r = List.generate(
      7,
      (weekday) => List.generate(
        13,
        (unit) => <Course>[],
        growable: false,
      ),
      growable: false,
    );

    for (final course in courses.values) {
      for (final period in course.periods!) {
        r[period.weekday!][period.unit!].add(course);
      }
    }

    return r;
  }

  static List<List<List<Course>>> get unitWeekday => List.generate(
        13,
        (unit) => List.generate(
          7,
          (weekday) => weekdayUnit[weekday][unit],
          growable: false,
        ),
        growable: false,
      );

  static List<int> get weekdays => range(7)
      .cast<int>()
      .where((weekday) => weekdayUnit[weekday].expand((l) => l).isNotEmpty)
      .toList();

  static List<int> get units => range(13)
      .cast<int>()
      .where((unit) => unitWeekday[unit].expand((l) => l).isNotEmpty)
      .toList();

  static String get areas {
    final r = StringBuffer();

    for (final unit in ['x', ...units]) {
      for (final weekday in ['x', ...weekdays]) {
        r.write('$weekday.$unit ');
      }
      r.writeln();
    }

    return r.toString();
  }
}
