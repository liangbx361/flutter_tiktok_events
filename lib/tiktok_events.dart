// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'tiktok_events_platform_interface.dart';

class TiktokEvents {
  Future<void> init(String appId, String tiktokAppId, bool debug) {
    return TiktokEventsPlatform.instance.init(appId, tiktokAppId, debug);
  }

  Future<void> setIdentity({
    required String userId,
    String? userName,
    String? email,
    String? phoneNumber,
  }) {
    return TiktokEventsPlatform.instance.setIdentity(userId, userName, email, phoneNumber);
  }

  Future<void> logout() {
    return TiktokEventsPlatform.instance.logout();
  }
}
