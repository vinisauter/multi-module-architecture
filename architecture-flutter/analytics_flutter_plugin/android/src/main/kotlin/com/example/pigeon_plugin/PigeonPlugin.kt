package com.example.pigeon_plugin

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** PigeonPlugin */
class PigeonPlugin: FlutterPlugin, Messages.ExampleApi {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Messages.ExampleApi.setup(flutterPluginBinding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Messages.ExampleApi.setup(binding.binaryMessenger, null)
    }

    override fun getPlatformVersion(): Messages.Version {
        var result = Messages.Version()
        result.string = "Android ${android.os.Build.VERSION.RELEASE}"
        return result
    }
}