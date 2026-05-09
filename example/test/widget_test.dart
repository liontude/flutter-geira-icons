import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geira_icons/geira_icons.dart';
import 'package:geira_icons_example/main.dart';

void main() {
  testWidgets('home screen shows title and icons', (tester) async {
    await tester.pumpWidget(const GeiraIconsApp());
    await tester.pumpAndSettle();

    expect(find.text('Geira Icons'), findsOneWidget);
    expect(find.byType(Icon), findsWidgets);
    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('search filters icons by name', (tester) async {
    await tester.pumpWidget(const GeiraIconsApp());
    await tester.pumpAndSettle();

    final initialCount = tester.widgetList(find.byType(Card)).length;

    await tester.enterText(find.byType(SearchBar), 'chat');
    await tester.pumpAndSettle();

    final filteredCount = tester.widgetList(find.byType(Card)).length;
    expect(filteredCount, lessThan(initialCount));
    expect(find.text('chat'), findsWidgets);
  });

  testWidgets('empty search shows no-results message', (tester) async {
    await tester.pumpWidget(const GeiraIconsApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'zzz_nonexistent');
    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsNothing);
    expect(find.textContaining('No icons found'), findsOneWidget);
  });

  testWidgets('tapping an icon tile navigates to detail page', (tester) async {
    await tester.pumpWidget(const GeiraIconsApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'chat');
    await tester.pumpAndSettle();

    await tester.tap(find.text('chat').first);
    await tester.pumpAndSettle();

    expect(find.byType(Hero), findsWidgets);
    expect(find.text('chat'), findsWidgets);
  });

  testWidgets('back button on detail page returns to home', (tester) async {
    await tester.pumpWidget(const GeiraIconsApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'chat');
    await tester.pumpAndSettle();
    await tester.tap(find.text('chat').first);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(GIcons.chevronLeft));
    await tester.pumpAndSettle();

    expect(find.text('Geira Icons'), findsOneWidget);
    expect(find.byType(SearchBar), findsOneWidget);
  });

  testWidgets('detail page shows icon name and codepoint', (tester) async {
    await tester.pumpWidget(const GeiraIconsApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'star');
    await tester.pumpAndSettle();

    await tester.tap(find.text('star').first);
    await tester.pumpAndSettle();

    expect(find.text('star'), findsWidgets);
    expect(find.textContaining('0x'), findsOneWidget);
  });
}
