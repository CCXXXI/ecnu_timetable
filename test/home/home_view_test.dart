import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecnu_timetable/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('HomePage Portrait', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);

    await tester.pumpWidget(GetMaterialApp(home: HomePage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.byType(BottomNavyBar), findsOneWidget);
  });

  testWidgets('HomePage Landscape', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await tester.pumpWidget(GetMaterialApp(home: HomePage()));

    expect(find.byType(AppBar), findsNothing);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(BottomNavyBar), findsNothing);
  });
}
