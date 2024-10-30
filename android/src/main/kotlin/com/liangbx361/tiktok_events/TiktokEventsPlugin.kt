package com.liangbx361.tiktok_events

import android.content.Context
import com.tiktok.TikTokBusinessSdk
import com.tiktok.TikTokBusinessSdk.TTInitCallback
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/**
 * Title:
 * Description:
 * Copyright © 2001-2024 17173. All rights reserved.
 *
 * @author liangbx
 * @version 2024/10/30
 */
class TiktokEventsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var context: Context

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "tiktok_events")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "init" -> init(call, result)
            "setIdentify" -> setIdentify(call, result)
            "logout" -> logout(call, result)
            else -> result.notImplemented()
        }
    }

    private fun init(call: MethodCall, result: MethodChannel.Result) {
        val appId = call.argument<String>("appId")
        val tiktokAppId = call.argument<String>("tiktokAppId")
        val debug = call.argument<Boolean>("debug") ?: false

        val ttConfig = TikTokBusinessSdk.TTConfig(context)
            .setAppId(appId)
            .setTTAppId(tiktokAppId)
            .enableAutoIapTrack()

        if (debug) {
            ttConfig.openDebugMode()
        }

        TikTokBusinessSdk.initializeSdk(ttConfig, object : TTInitCallback {
            override fun success() {
                TikTokBusinessSdk.startTrack()
                result.success(null)
            }

            override fun fail(code: Int, message: String) {
                result.error(code.toString(), message, null)
            }
        })
    }

    private fun setIdentify(call: MethodCall, result: MethodChannel.Result) {
        val userId = call.argument<String>("userId")
        val userName = call.argument<String?>("userName")
        val email = call.argument<String?>("email")
        val phoneNumber = call.argument<String?>("phoneNumber")

        TikTokBusinessSdk.identify(userId, userName, email, phoneNumber)
        result.success(null)
    }

    private fun logout(call: MethodCall, result: MethodChannel.Result) {
        TikTokBusinessSdk.logout()
        result.success(null)
    }
}