import Flutter
import TikTokBusinessSDK
import UIKit

public class TiktokEventsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "tiktok_events", binaryMessenger: registrar.messenger())
    let instance = TiktokEventsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "init":
      initSdk(call: call, result: result)
    case "setIdentity":
      setIdentity(call: call, result: result)
    case "logout":
      logout(call: call, result: result)
    default:     
      result(FlutterMethodNotImplemented)
    }
  }

  private func initSdk(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
      let appId = args["appId"] as? String,
      let tiktokAppId = args["tiktokAppId"] as? String,
      let debug = args["debug"] as? Bool
    else {
      result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
      return
    }

    let config = TikTokConfig.init(appId: appId, tiktokAppId: tiktokAppId)
    if debug {
      config?.enableDebugMode()
    }

    TikTokBusiness.initializeSdk(config) { success, error in
      if !success {  // initialization failed
        result(
          FlutterError(
            code: "INITIALIZATION_FAILED", message: error?.localizedDescription, details: nil))
      } else {  // initialization successful
        result(nil)
      }
    }
  }

  private func setIdentity(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
      let userId = args["userId"] as? String
    else {
      result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
      return
    }

    let userName = args["userName"] as? String
    let email = args["email"] as? String
    let phoneNumber = args["phoneNumber"] as? String

    TikTokBusiness.identify(withExternalID: userId, externalUserName: userName, phoneNumber: phoneNumber, email: email)
      
    result(nil)
  }

  private func logout(call: FlutterMethodCall, result: @escaping FlutterResult) {
    TikTokBusiness.logout()
    result(nil)
  }
}
