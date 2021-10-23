import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

import '../utils/database.dart';
import 'timetable_menu/timetable_menu_view.dart';

class TimetableLogic extends GetxController {
  static void openMenu() => Get.to(() => TimetableMenuPage());

  static List<List<List<Course>>> get _weekdayUnit {
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

  static List<List<List<Course>>> get _unitWeekday => List.generate(
        13,
        (unit) => List.generate(
          7,
          (weekday) => _weekdayUnit[weekday][unit],
          growable: false,
        ),
        growable: false,
      );

  static List<int> get weekdays => range(7)
      .cast<int>()
      .where((weekday) => _weekdayUnit[weekday].expand((l) => l).isNotEmpty)
      .toList();

  static List<int> get units => range(13)
      .cast<int>()
      .where((unit) => _unitWeekday[unit].expand((l) => l).isNotEmpty)
      .toList();

  static List<List<String>> get areasRaw {
    final r = <List<String>>[];

    for (final weekday in ['x', ...weekdays]) {
      r.add([]);
      for (final unit in ['x', ...units]) {
        if (weekday == 'x' ||
            unit == 'x' ||
            unit == 0 ||
            _weekdayUnit[weekday as int][unit as int].toString() !=
                _weekdayUnit[weekday][unit - 1].toString()) {
          r.last.add('$weekday-$unit');
        } else {
          r.last.add(r.last.last);
        }
      }
    }

    return r;
  }

  static String get areas {
    final r = StringBuffer();

    for (var unitIdx = 0; unitIdx <= units.length; unitIdx++) {
      for (var weekdayIdx = 0; weekdayIdx <= weekdays.length; weekdayIdx++) {
        r.write(areasRaw[weekdayIdx][unitIdx] + ' ');
      }
      r.writeln();
    }

    return r.toString();
  }
}
