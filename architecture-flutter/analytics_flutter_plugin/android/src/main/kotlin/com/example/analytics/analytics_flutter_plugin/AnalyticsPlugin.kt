package com.example.analytics.analytics_flutter_plugin

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

/** PigeonPlugin */
class AnalyticsPlugin: FlutterPlugin, Analytics.AnalyticsApi {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
//    private lateinit var channel : MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Analytics.AnalyticsApi.setup(flutterPluginBinding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Analytics.AnalyticsApi.setup(binding.binaryMessenger, null)
    }

    override fun sendScreenView(eventName: String?) {
        Log.v("ANALYTICS", "eventName: $eventName")
    }

    override fun sendInteraction(category: String?, action: String?, label: String?) {
        Log.v("ANALYTICS", "category: $category, action: $action, label: $label")
    }

//    override fun getPlatformVersion(): Analytics.Version {
//        var result = Analytics.Version()
//        result.string = "Android ${android.os.Build.VERSION.RELEASE}"
//        return result
//    }
}