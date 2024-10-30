import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tiktok_events_method_channel.dart';

abstract class TiktokEventsPlatform extends PlatformInterface {
  /// Constructs a FlutterTiktokEventsPlatform.
  TiktokEventsPlatform() : super(token: _token);

  static final Object _token = Object();

  static TiktokEventsPlatform _instance = MethodChannelTiktokEvents();

  /// The default instance of [TiktokEventsPlatform] to use.
  ///
  /// Defaults to [MethodChannelTiktokEvents].
  static TiktokEventsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TiktokEventsPlatform] when
  /// they register themselves.
  static set instance(TiktokEventsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init(String appId, String tiktokAppId, bool debug);

  Future<void> setIdentity(String userId, String? userName, String? email, String? phoneNumber);

  Future<void> logout();
}
