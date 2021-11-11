package com.example.flutter

import android.content.Context
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class FlutterEngineExecutor(context: Context, entrypoint: String) {

    companion object {
        private var engines: FlutterEngineGroup? = null

        @Synchronized
        fun start(context: Context) {
            if (engines == null) {
                engines = FlutterEngineGroup(context)
            }
        }

        @Synchronized
        fun stop() {
            if (engines != null) {
                engines = null
            }
        }

        fun getEngines(): FlutterEngineGroup {
            return engines!!
        }
    }

    val engine: FlutterEngine
    private val channel: MethodChannel

    init {
        // This has to be lazy to avoid creation before the FlutterEngineGroup.
        val dartEntrypoint =
            DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(), entrypoint
            )
        engine = getEngines().createAndRunEngine(context, dartEntrypoint)
        channel = MethodChannel(engine.dartExecutor.binaryMessenger, "multiple-flutters")
    }

    fun invokeMethod(name: String, intValue: Int) {
        channel.invokeMethod(name, intValue)
    }

    fun setMethodCallHandler(handler: MethodChannel.MethodCallHandler?) {
        channel.setMethodCallHandler(handler)
    }

    fun detachMethodCallHandler() {
        channel.setMethodCallHandler(null)
    }
}