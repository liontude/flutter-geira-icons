# Geira Icons

The [Geira Icons](https://icons.geira.com/) family available as a Flutter icon font package. Each icon is designed with visual uniformity and balance in mind.

[![pub.dev](https://img.shields.io/pub/v/geira_icons.svg)](https://pub.dev/packages/geira_icons)

## Requirements

- Dart `>=3.0.0 <4.0.0`
- Flutter `>=3.10.0`

## Installation

Add `geira_icons` to your `pubspec.yaml`:

```yaml
dependencies:
  geira_icons: ^4.0.0
```

Then run:

```sh
flutter pub get
```

## Usage

Import the package and use any icon via the `GIcons` class:

```dart
import 'package:geira_icons/geira_icons.dart';

Icon(GIcons.star)
Icon(GIcons.search, size: 32, color: Colors.blue)
Icon(GIcons.chevronRight)
```

### Look up an icon by name

Icon names use kebab-case (matching the original Geira Icons identifiers):

```dart
final icon = GIcons.byName('chevron-right'); // returns IconData?
final icon = GIcons.byName('notifications-off');
```

### List all available icons

```dart
// Iterable<String> of all icon names in kebab-case
for (final name in GIcons.iconNames) {
  print(name);
}

// Map<String, IconData> of every icon
final all = GIcons.all;
```

## Icon browser

Visit [icons.geira.com](https://icons.geira.com/) to browse and search all available icons.

## License

MIT — see [LICENSE](LICENSE).
