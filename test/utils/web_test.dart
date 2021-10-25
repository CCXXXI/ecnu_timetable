import 'package:ecnu_timetable/utils/web.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'dio',
    () => expect(
      defaultDio.interceptors,
      isNotEmpty,
    ),
  );

  test(
    'sucker',
    () => expect(
      Api.randomSucker,
      isNotEmpty,
    ),
  );

  test(
    'version url',
    () => expect(
      Url.version('0.1.0'),
      'https://github.com/CCXXXI/ecnu_timetable/releases/tag/v0.1.0',
    ),
  );

  test(
    'ics',
    () => expect(
      Url.ics('10101001000', 'abc', 2021, 0),
      'http://application.jjaychen.me/ecnu-service/course-calendar'
      '?username=10101001000&password=abc&year=2021&semesterIndex=1',
    ),
  );
}
