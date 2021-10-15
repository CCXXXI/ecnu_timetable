import 'package:ecnu_timetable/timetable/ecnu/des.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('des', () {
    expect(strEnc('data'), '34AE5DC1AD2BDA92');
    expect(strEnc('ecnu'), '0DB9498F9C7706F3');
    expect(strEnc('0DB9498F9C7706F3'),
        '794EE509D7F1CBF640C9ED7B4EB5AB94E88F1C4B9F0D24DE709C5839C7BCB533');
    expect(strEnc('10101001000@abcdefg.ecnu.edu.cn'),
        'D12781756C6D8485844A7F48326289AF905F80BCD2274407A9CF2704230383D1DEC97A59E1771F1C0DB9498F9C7706F32D0C03A9D6850DDCE4F8A1319CB7AA56');
  });
}
