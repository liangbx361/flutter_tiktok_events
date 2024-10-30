import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tiktok_events/tiktok_events.dart';
import 'package:flutter_tiktok_events/tiktok_events_platform_interface.dart';
import 'package:flutter_tiktok_events/tiktok_events_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTiktokEventsPlatform
    with MockPlatformInterfaceMixin
    implements TiktokEventsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TiktokEventsPlatform initialPlatform = TiktokEventsPlatform.instance;

  test('$MethodChannelTiktokEvents is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokEvents>());
  });

  test('getPlatformVersion', () async {
    TiktokEvents flutterTiktokEventsPlugin = TiktokEvents();
    MockFlutterTiktokEventsPlatform fakePlatform = MockFlutterTiktokEventsPlatform();
    TiktokEventsPlatform.instance = fakePlatform;

    expect(await flutterTiktokEventsPlugin.getPlatformVersion(), '42');
  });
}
