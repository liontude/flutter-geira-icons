import 'package:flutter_test/flutter_test.dart';
import 'package:geira_icons/geira_icons.dart';

void main() {
  group('GIcons.byName', () {
    test('returns correct IconData for simple names', () {
      expect(GIcons.byName('pencil'), GIcons.pencil);
      expect(GIcons.byName('wifi'), GIcons.wifi);
      expect(GIcons.byName('none'), GIcons.none);
      expect(GIcons.byName('search'), GIcons.search);
      expect(GIcons.byName('star'), GIcons.star);
    });

    test('returns correct IconData for camelCase compound names', () {
      expect(GIcons.byName('chevronUp'), GIcons.chevronUp);
      expect(GIcons.byName('chevronLeft'), GIcons.chevronLeft);
      expect(GIcons.byName('notificationsOff'), GIcons.notificationsOff);
      expect(GIcons.byName('favoriteBorder'), GIcons.favoriteBorder);
      expect(GIcons.byName('arrowRight'), GIcons.arrowRight);
    });

    test('returns null for unknown names', () {
      expect(GIcons.byName('unknown'), isNull);
      expect(GIcons.byName(''), isNull);
    });

    test('is case-sensitive', () {
      expect(GIcons.byName('Pencil'), isNull);
      expect(GIcons.byName('WIFI'), isNull);
      expect(GIcons.byName('ChevronUp'), isNull);
    });

    test('result matches corresponding static constant codePoint', () {
      expect(GIcons.byName('pencil')!.codePoint, GIcons.pencil.codePoint);
      expect(GIcons.byName('wifi')!.codePoint, GIcons.wifi.codePoint);
    });
  });

  group('GIcons.iconNames', () {
    test('contains simple icon names', () {
      final names = GIcons.iconNames;
      expect(names, contains('none'));
      expect(names, contains('pencil'));
      expect(names, contains('brush'));
      expect(names, contains('wifi'));
      expect(names, contains('search'));
      expect(names, contains('star'));
    });

    test('contains camelCase compound names', () {
      final names = GIcons.iconNames;
      expect(names, contains('chevronUp'));
      expect(names, contains('chevronLeft'));
      expect(names, contains('notificationsOff'));
      expect(names, contains('favoriteBorder'));
    });

    test('does not contain kebab-case names', () {
      final names = GIcons.iconNames.toList();
      expect(names, isNot(contains('chevron-up')));
      expect(names, isNot(contains('notifications-off')));
      expect(names, isNot(contains('favorite-border')));
    });

    test('is non-empty', () {
      expect(GIcons.iconNames, isNotEmpty);
    });

    test('contains more than 200 icons', () {
      expect(GIcons.iconNames.length, greaterThan(200));
    });
  });

  group('GIcons.all', () {
    test('has the same keys as iconNames', () {
      expect(GIcons.all.keys, containsAll(GIcons.iconNames));
      expect(GIcons.all.length, equals(GIcons.iconNames.length));
    });

    test('byName and all return the same IconData', () {
      expect(GIcons.byName('pencil'), equals(GIcons.all['pencil']));
      expect(GIcons.byName('wifi'), equals(GIcons.all['wifi']));
      expect(GIcons.byName('chevronUp'), equals(GIcons.all['chevronUp']));
    });

    test('values are non-null', () {
      for (final iconData in GIcons.all.values) {
        expect(iconData, isNotNull);
      }
    });
  });

  group('GIcons static constants', () {
    test('have correct codePoints', () {
      expect(GIcons.none.codePoint, 0xe000);
      expect(GIcons.pencil.codePoint, 0xe001);
      expect(GIcons.brush.codePoint, 0xe002);
      expect(GIcons.wifi.codePoint, 0xe004);
      expect(GIcons.chevronUp.codePoint, 0xe02d);
      expect(GIcons.chevronLeft.codePoint, 0xe03a);
      expect(GIcons.search.codePoint, 0xe245);
      expect(GIcons.star.codePoint, 0xe210);
    });

    test('have correct fontFamily', () {
      expect(GIcons.pencil.fontFamily, 'Geira Icons');
      expect(GIcons.wifi.fontFamily, 'Geira Icons');
      expect(GIcons.star.fontFamily, 'Geira Icons');
    });

    test('have correct fontPackage', () {
      expect(GIcons.pencil.fontPackage, 'geira_icons');
      expect(GIcons.wifi.fontPackage, 'geira_icons');
      expect(GIcons.star.fontPackage, 'geira_icons');
    });
  });

  group('GIcons equality', () {
    test('same codePoint constants are equal', () {
      expect(GIcons.pencil, equals(GIcons.pencil));
      expect(GIcons.wifi, equals(GIcons.wifi));
    });

    test('different codePoint constants are not equal', () {
      expect(GIcons.pencil, isNot(equals(GIcons.wifi)));
      expect(GIcons.star, isNot(equals(GIcons.starBorder)));
    });

    test('byName result equals the static constant', () {
      expect(GIcons.byName('pencil'), equals(GIcons.pencil));
      expect(GIcons.byName('star'), equals(GIcons.star));
      expect(GIcons.byName('chevronUp'), equals(GIcons.chevronUp));
    });
  });
}
