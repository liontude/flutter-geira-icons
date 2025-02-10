import 'package:flutter_test/flutter_test.dart';
import 'package:geira_icons/geira_icons.dart';

void main() {
  group('GIcons Tests', () {
    test('should return correct IconData for known key', () {
      expect(GIcons.fromString('pencil'), GIcons.pencil);
      expect(GIcons.fromString('wifi'), GIcons.wifi);
    });

    test('should return null for unknown key', () {
      expect(GIcons.fromString('unknown'), isNull);
    });

    test('should retrieve all icon names', () {
      final icons = GIcons.getIconsName();
      expect(icons, containsAll(['none', 'pencil', 'brush', 'wifi']));
    });
  });
}
