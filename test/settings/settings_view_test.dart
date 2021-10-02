import 'package:ecnu_timetable/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'settings_logic_test.dart';

class MockAnonymousSettingsPage extends SettingsPage {
  MockAnonymousSettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: overridden_fields
  final logic = Get.put(
    MockSettingsLogic(),
    tag: 'anonymous',
  );
}

class MockUserSettingsPage extends SettingsPage {
  MockUserSettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: overridden_fields
  final logic = Get.put(
    MockSettingsLogic(id: mockId, username: mockUsername),
    tag: 'user',
  );
}

Widget wrapper(Widget child) => GetMaterialApp(home: Scaffold(body: child));

void main() async {
  testWidgets('SettingsPage Anonymous', (tester) async {
    await Settings.init();
    await tester.pumpWidget(wrapper(MockAnonymousSettingsPage()));

    expect(find.widgetWithIcon(ListTile, Icons.login), findsOneWidget);
    expect(find.widgetWithIcon(ListTile, Icons.logout), findsNothing);
  });

  testWidgets('SettingsPage User', (tester) async {
    await Settings.init();
    await tester.pumpWidget(wrapper(MockUserSettingsPage()));

    expect(find.widgetWithIcon(ListTile, Icons.login), findsNothing);
    expect(find.widgetWithIcon(ListTile, Icons.logout), findsOneWidget);

    expect(find.text(mockId), findsOneWidget);
    expect(find.text(mockUsername), findsOneWidget);
  });
}
