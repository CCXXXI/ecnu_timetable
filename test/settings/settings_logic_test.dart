import 'package:ecnu_timetable/settings/settings_logic.dart';
import 'package:ecnu_timetable/utils/messages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockSettingsLogic extends SettingsLogic {
  @override
  final String? id, username;
  final String latestVer_;

  MockSettingsLogic({this.id, this.username, this.latestVer_ = version});

  @override
  void updateVerInfo() async => latestVer.value = latestVer_;
}

const mockId = '10101001000';
const mockUsername = 'ECNUer';

void main() {
  group('Anonymous', () {
    final logic = Get.put(MockSettingsLogic());

    test('not logged in', () => expect(logic.loggedIn, isFalse));
    test('id is null', () => expect(logic.id, isNull));
    test('username is null', () => expect(logic.username, isNull));

    Get.delete<MockSettingsLogic>();
  });

  group('User', () {
    final logic =
        Get.put(MockSettingsLogic(id: mockId, username: mockUsername));

    test('logged in', () => expect(logic.loggedIn, isTrue));
    test('id', () => expect(logic.id, mockId));
    test('username', () => expect(logic.username, mockUsername));

    Get.delete<MockSettingsLogic>();
  });

  group('Update', () {
    final logic0 = Get.put(MockSettingsLogic());
    test('not available', () => expect(logic0.updateAvailable, isFalse));
    Get.delete<MockSettingsLogic>();

    final logic1 = Get.put(MockSettingsLogic(latestVer_: '1024.2048.4096'));
    test('available', () => expect(logic1.updateAvailable, isTrue));
    Get.delete<MockSettingsLogic>();
  });
}
