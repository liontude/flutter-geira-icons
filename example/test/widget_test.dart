import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geira_icons/geira_icons.dart';
import 'package:geira_icons_example/main.dart';

void main() {
  testWidgets('Verify Geira Icons App displays icons and search works', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GeiraIconsApp());

    expect(find.text('Geira Icons'), findsOneWidget);
    expect(find.byType(Icon), findsWidgets);

    await tester.tap(find.byIcon(GIcons.search));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'chat');
    await tester.pumpAndSettle();

    // The search TextField also contains 'chat', so at least 2 widgets match.
    expect(find.text('chat'), findsAtLeastNWidgets(2));

    // Tap the icon label in the grid (last match, not the input field).
    await tester.tap(find.text('chat').last);
    await tester.pumpAndSettle();

    expect(find.byType(Hero), findsOneWidget);

    await tester.tap(find.byIcon(GIcons.chevronLeft));
    await tester.pumpAndSettle();

    expect(find.text('Geira Icons'), findsOneWidget);
  });
}
