import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'geira_icons_platform_interface.dart';

/// An implementation of [GeiraIconsPlatform] that uses method channels.
class MethodChannelGeiraIcons extends GeiraIconsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('geira_icons');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
