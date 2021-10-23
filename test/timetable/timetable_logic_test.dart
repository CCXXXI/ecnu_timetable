import 'package:ecnu_timetable/timetable/ecnu/ecnu_logic.dart';
import 'package:ecnu_timetable/timetable/timetable_logic.dart';
import 'package:ecnu_timetable/utils/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ecnu/ecnu_logic_test.dart';

void main() {
  setUpAll(() async {
    await initDatabase(clear: true);

    final r = EcnuLogic.getCourses(coursesJs);
    courses.addAll(r);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test(
    'areas',
    () => expect(
      TimetableLogic.areas.replaceAll(' \n', '\n'),
      '''
x.x 0.x 1.x 3.x 4.x
x.0 0.0 1.0 3.0 4.0
x.1 0.1 1.1 3.1 4.1
x.2 0.2 1.2 3.2 4.2
x.3 0.3 1.3 3.3 4.3
x.5 0.5 1.5 3.5 4.5
x.6 0.6 1.6 3.6 4.6
x.7 0.7 1.7 3.7 4.7
x.8 0.8 1.8 3.8 4.8
x.10 0.10 1.10 3.10 4.10
x.11 0.11 1.11 3.11 4.11
x.12 0.12 1.12 3.12 4.12
''',
    ),
  );
}
