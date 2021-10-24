import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

import '../utils/database.dart';

class TimetableLogic extends GetxController {
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

  static List<List<List<Course>>> get _unitWeekday {
    final weekdayUnit_ = _weekdayUnit;

    return List.generate(
      13,
      (unit) => List.generate(
        7,
        (weekday) => weekdayUnit_[weekday][unit],
        growable: false,
      ),
      growable: false,
    );
  }

  static List<int> get weekdays {
    final weekdayUnit_ = _weekdayUnit;

    return range(7)
        .cast<int>()
        .where((weekday) => weekdayUnit_[weekday].expand((l) => l).isNotEmpty)
        .toList();
  }

  static List<int> get units {
    final unitWeekday_ = _unitWeekday;

    return range(13)
        .cast<int>()
        .where((unit) => unitWeekday_[unit].expand((l) => l).isNotEmpty)
        .toList();
  }

  static List<List<String>> get _areasRaw {
    final weekdays_ = weekdays;
    final units_ = units;
    final weekdayUnit_ = _weekdayUnit;

    final r = <List<String>>[];

    for (final weekday in ['x', ...weekdays_]) {
      r.add([]);
      for (final z in zip([
        ['x', ...units_],
        ['', 'x', ...units_],
      ])) {
        final unit = z.first;
        final pre = z.last;
        if (weekday == 'x' ||
            unit == 'x' ||
            unit == 0 ||
            weekdayUnit_[weekday as int][unit as int].toString() !=
                weekdayUnit_[weekday][pre as int].toString()) {
          r.last.add('$weekday-$unit');
        } else {
          r.last.add(r.last.last);
        }
      }
    }

    return r;
  }

  static String get areas {
    final weekdays_ = weekdays;
    final units_ = units;
    final areasRaw_ = _areasRaw;

    final r = StringBuffer();

    for (var unitIdx = 0; unitIdx <= units_.length; unitIdx++) {
      for (var weekdayIdx = 0; weekdayIdx <= weekdays_.length; weekdayIdx++) {
        r.write(areasRaw_[weekdayIdx][unitIdx] + ' ');
      }
      r.writeln();
    }

    return r.toString();
  }

  static List<_CoursePeriod> get sortedCourses {
    final areasList = _areasRaw.expand((e) => e).toList();

    final r = <_CoursePeriod>[];

    for (final course in courses.values) {
      for (final period in course.periods!) {
        if (areasList.contains('${period.weekday}-${period.unit}')) {
          r.add(_CoursePeriod(course, period));
        }
      }
    }

    r.sort(
      (a, b) =>
          (b.period.weekday! * 42 + b.period.unit!) -
          (a.period.weekday! * 42 + a.period.unit!),
    );

    return r;
  }
}

class _CoursePeriod {
  Course course;
  Period period;

  _CoursePeriod(this.course, this.period);
}
