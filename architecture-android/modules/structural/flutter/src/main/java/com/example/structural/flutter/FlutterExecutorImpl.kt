package com.example.structural.flutter

import android.content.Context
import android.net.Uri
import androidx.fragment.app.Fragment
import com.example.flutter.FlutterExecutor
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.ApplicationInfoLoader
import io.flutter.embedding.engine.loader.FlutterLoader

class FlutterExecutorImpl : FlutterExecutor {
    private val engineCache: FlutterEngineCache = FlutterEngineCache.getInstance()

    private var fragments: MutableMap<String, FlutterFragment> = mutableMapOf()

    override fun getFragment(context: Context, moduleName: String, engineId: String): Fragment {
//            val engine = FlutterEngine(context)

        val jni = FlutterJNI()
        val loader = FlutterLoader(jni)
        loader.startInitialization(context)
        val engine = FlutterEngine(context, loader, jni)
//        FlutterLoader
//        context.packageManager.getActivityInfo((context as ModuleControllerActivity).componentName, PackageManager.GET_META_DATA).metaData.getString("io.flutter.embedding.engine.loader.FlutterLoader.flutter-assets-dir")

//        val entrypoint = DartExecutor.DartEntrypoint.createDefault()
        val entrypoint = DartExecutor.DartEntrypoint("flutter_assets_$moduleName", "main")

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
        fragments[engineId]?.let {
            it.detachFromFlutterEngine()
            fragments.remove(engineId)
        }

        engineCache.get(engineId)?.let {
            it.destroy()
            engineCache.remove(engineId)
        }
    }
}
