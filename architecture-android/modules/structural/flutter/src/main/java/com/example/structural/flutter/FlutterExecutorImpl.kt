package com.example.structural.flutter

import android.content.Context
import android.content.res.AssetManager
import android.net.Uri
import androidx.fragment.app.Fragment
import com.example.flutter.FlutterExecutor
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.view.FlutterMain

class FlutterExecutorImpl : FlutterExecutor {
    private val engineCache: FlutterEngineCache = FlutterEngineCache.getInstance()

    private var fragments: MutableMap<String, FlutterFragment> = mutableMapOf()

    override fun getFragment(context: Context, engineId: String): Fragment {
//        val jni = FlutterJNI()
//        jni.attachToNative()
//        jni.init(context, emptyArray(), "flutter_assets", "", "", 0)

        val engine = FlutterEngine(context)
//        val engine = FlutterEngine(context, null, jni)

        val entrypoint = DartExecutor.DartEntrypoint.createDefault()
//        val entrypoint = DartExecutor.DartEntrypoint("", "")

        engine.dartExecutor.executeDartEntrypoint(entrypoint)
        engineCache.put(engineId, engine)

        val fragment = FlutterFragment
            .withCachedEngine(engineId)
            .destroyEngineWithFragment(true)
            .build<FlutterFragment>()

        fragments[engineId] = fragment
        return fragment
    }

    override fun handleDeeplink(deeplink: Uri, engineId: String) {
        TODO("Not yet implemented")
    }

    override fun destroyEngine(engineId: String) {
        fragments[engineId]?.detachFromFlutterEngine()

        engineCache.get(engineId)?.let {
            it.destroy()
            engineCache.remove(engineId)
        }
    }
}