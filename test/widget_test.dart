import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_ui_app/main.dart';

void main() {
  testWidgets('App renders MainNavigation widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the main navigation appears on screen.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('News'), findsOneWidget);
  });

  testWidgets('Navigate to NewsFeedPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on the News tab.
    await tester.tap(find.text('News'));
    await tester.pumpAndSettle();

    // Verify that NewsFeedPage is displayed.
    expect(find.text('News Feed'), findsOneWidget);
  });
}
