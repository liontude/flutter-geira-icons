
import 'geira_icons_platform_interface.dart';

class GeiraIcons {
  Future<String?> getPlatformVersion() {
    return GeiraIconsPlatform.instance.getPlatformVersion();
  }
}
