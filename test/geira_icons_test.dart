import 'package:flutter_test/flutter_test.dart';
import 'package:geira_icons/geira_icons.dart';
import 'package:geira_icons/geira_icons_platform_interface.dart';
import 'package:geira_icons/geira_icons_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGeiraIconsPlatform
    with MockPlatformInterfaceMixin
    implements GeiraIconsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GeiraIconsPlatform initialPlatform = GeiraIconsPlatform.instance;

  test('$MethodChannelGeiraIcons is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGeiraIcons>());
  });

  test('getPlatformVersion', () async {
    GeiraIcons geiraIconsPlugin = GeiraIcons();
    MockGeiraIconsPlatform fakePlatform = MockGeiraIconsPlatform();
    GeiraIconsPlatform.instance = fakePlatform;

    expect(await geiraIconsPlugin.getPlatformVersion(), '42');
  });
}
