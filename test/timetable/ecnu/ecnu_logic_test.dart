import 'package:ecnu_timetable/timetable/ecnu/ecnu_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('semester.id', () {
    expect(EcnuLogic.semId(2018, 0), 705);
    expect(EcnuLogic.semId(2018, 1), 705 + 32);
    expect(EcnuLogic.semId(2017, 2), 705 - 32);
  });
}
