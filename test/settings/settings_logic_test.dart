import 'package:ecnu_timetable/settings/settings_logic.dart';
import 'package:ecnu_timetable/utils/string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class MockSettingsLogic extends SettingsLogic {
  final String? latestVer_;

  MockSettingsLogic({this.latestVer_});

  @override
  void updateVerInfo() async => latestVer.value = latestVer_;
}

void main() {
  group('Update', () {
    final logic0 = Get.put(MockSettingsLogic());
    test('not available', () => expect(logic0.updateAvailable, isFalse));
    Get.delete<MockSettingsLogic>();

    final logic1 = Get.put(MockSettingsLogic(latestVer_: version));
    test('not available', () => expect(logic1.updateAvailable, isFalse));
    Get.delete<MockSettingsLogic>();

    final logic2 = Get.put(MockSettingsLogic(latestVer_: '1024.2048.4096'));
    test('available', () => expect(logic2.updateAvailable, isTrue));
    Get.delete<MockSettingsLogic>();
  });
}
