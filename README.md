# Geira Icons

The [Geira Icons](https://icons.geira.com/) pack available as set of Flutter Icons.

👍 Like us on [pub.dev](https://pub.dev/packages/geira_icons)!

## Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
  geira_icons: ^3.0.0
```

## Usage

```dart
import 'package:geira_icons/geira_icons.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
                child: Icon(
                  // Use GIcons. Where googleLogo is the name of the icon
                  GIcons.googleLogo,
                  color: Colors.red,
                  size: 50.0,
                ),
          );  
  }
}
```