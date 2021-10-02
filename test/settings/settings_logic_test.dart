import 'package:ecnu_timetable/settings/settings_logic.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSettingsLogic extends SettingsLogic {
  @override
  final String? id, username;

  MockSettingsLogic({this.id, this.username});
}

const mockId = '10101001000';
const mockUsername = 'ECNUer';

void main() {
  group('Anonymous', () {
    final logic = MockSettingsLogic();

    test('not logged in', () => expect(logic.loggedIn, isFalse));
    test('id is null', () => expect(logic.id, isNull));
    test('username is null', () => expect(logic.username, isNull));
  });

  group('User', () {
    final logic = MockSettingsLogic(id: mockId, username: mockUsername);

    test('logged in', () => expect(logic.loggedIn, isTrue));
    test('id', () => expect(logic.id, mockId));
    test('username', () => expect(logic.username, mockUsername));
  });
}
