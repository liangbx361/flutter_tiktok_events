import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tiktok_events_platform_interface.dart';

/// An implementation of [TiktokEventsPlatform] that uses method channels.
class MethodChannelTiktokEvents extends TiktokEventsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiktok_events');
  
  @override
  Future<void> init(String appId, String tiktokAppId, bool debug) async {
    await methodChannel.invokeMethod<void>('init', <String, dynamic>{
      'appId': appId,
      'tiktokAppId': tiktokAppId,
      'debug': debug,
    });
  }
  
  @override
  Future<void> setIdentity(String userId, String? userName, String? email, String? phoneNumber) async {
    await methodChannel.invokeMethod<void>('setIdentity', <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  @override
  Future<void> logout() async {
    await methodChannel.invokeMethod<void>('logout');
  }
}
