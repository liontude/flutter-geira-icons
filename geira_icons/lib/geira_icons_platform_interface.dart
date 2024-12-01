import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geira_icons_method_channel.dart';

abstract class GeiraIconsPlatform extends PlatformInterface {
  /// Constructs a GeiraIconsPlatform.
  GeiraIconsPlatform() : super(token: _token);

  static final Object _token = Object();

  static GeiraIconsPlatform _instance = MethodChannelGeiraIcons();

  /// The default instance of [GeiraIconsPlatform] to use.
  ///
  /// Defaults to [MethodChannelGeiraIcons].
  static GeiraIconsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GeiraIconsPlatform] when
  /// they register themselves.
  static set instance(GeiraIconsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
