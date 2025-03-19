import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:laboratornaya4/main.dart';

void main() {
  testWidgets('HostelApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( HostelApp());

    // Verify that the app bar title is correct.
    expect(find.text('Общежития КУБГАУ'), findsOneWidget);

    // Verify that the image is displayed.
    expect(find.byType(Image), findsOneWidget);

    // Verify that the buttons are displayed.
    expect(find.text('Позвонить'), findsOneWidget);
    expect(find.text('Маршрут'), findsOneWidget);
    expect(find.text('Поделиться'), findsOneWidget);

    // Verify that the description text is displayed.
    expect(find.text('Описание общежития...'), findsOneWidget);
  });
}