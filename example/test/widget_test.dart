import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geira_icons/geira_icons.dart';

import 'package:geira_icons_example/main.dart';

void main() {
  testWidgets('Verify Geira Icons App displays icons and search works',
      (WidgetTester tester) async {
    // Build the GeiraIconsApp and trigger a frame.
    await tester.pumpWidget(const GeiraIconsApp());

    // Verify that the title "Geira Icons" is displayed.
    expect(find.text('Geira Icons'), findsOneWidget);

    // Verify that at least one icon is displayed.
    expect(find.byType(Icon), findsWidgets);

    // Tap the search icon to activate search mode.
    await tester.tap(find.byIcon(GIcons.search));
    await tester.pumpAndSettle();

    // Enter text in the search bar.
    await tester.enterText(find.byType(TextField), 'chat');
    await tester.pumpAndSettle();

    // Verify that the icon related to 'chat' is displayed.
    expect(find.text('chat'), findsOneWidget);

    // Tap the icon to view the enlarged version.
    await tester.tap(find.text('chat'));
    await tester.pumpAndSettle();

    // Verify that the enlarged icon is displayed.
    expect(find.byType(Hero), findsOneWidget);

    // Tap the back button to return to the home screen.
    await tester.tap(find.byIcon(GIcons.chevronLeft));
    await tester.pumpAndSettle();

    // Verify that we're back on the home screen.
    expect(find.text('Geira Icons'), findsOneWidget);
  });
}
