import 'package:ecnu_timetable/toolbox/juan/juan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('JuanWidget', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: JuanWidget())));

    final a = find.widgetWithText(TextFormField, '已选');
    final b = find.widgetWithText(TextFormField, '上限');
    final invalid = find.widgetWithText(TextFormField, 'invalid');

    expect(find.text('0'), findsOneWidget);
    expect(a, findsOneWidget);
    expect(b, findsOneWidget);

    await tester.enterText(a, '0');
    await tester.pump();
    expect(find.text('0'), findsNWidgets(2));
    expect(invalid, findsOneWidget);

    await tester.enterText(b, '0');
    await tester.pump();
    expect(find.text('0'), findsNWidgets(3));
    expect(invalid, findsOneWidget);

    await tester.enterText(b, '1');
    await tester.pump();
    expect(find.text('0'), findsNWidgets(2));
    expect(invalid, findsNothing);

    await tester.enterText(a, '1');
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(invalid, findsNothing);

    await tester.enterText(a, '2');
    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(invalid, findsNothing);

    await tester.enterText(b, '1' * 1024);
    await tester.pump();
    expect(invalid, findsOneWidget);
  });
}
