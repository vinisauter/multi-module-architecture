package com.example.structural.flutter

import android.content.Context
import android.net.Uri
import androidx.fragment.app.Fragment
import com.example.flutter.FlutterExecutor
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class FlutterExecutorImpl : FlutterExecutor {
    private val engineCache: FlutterEngineCache = FlutterEngineCache.getInstance()

    private var fragments: MutableMap<String, FlutterFragment> = mutableMapOf()

    override fun getFragment(context: Context, engineId: String): Fragment {
        if (!engineCache.contains(engineId)) {
            val flutterLoader = CustomFlutterInjector.instance().flutterLoader()
            val jni = CustomFlutterInjector.instance().flutterJNIFactory.provideFlutterJNI()
            val engine = CustomFlutterEngine(context, flutterLoader, jni)

            val entrypoint =
                DartExecutor.DartEntrypoint("flutter_assets_${extractModule(engineId)}", "main")

            engine.dartExecutor.executeDartEntrypoint(entrypoint)

            val newFlutterEngine = FlutterEngine(context, flutterLoader, jni, null, false)

            engineCache.put(engineId, newFlutterEngine)
        }

        val fragment = FlutterFragment
            .withCachedEngine(engineId)
            .destroyEngineWithFragment(false)
            .build<FlutterFragment>()

        fragments[engineId] = fragment
        return fragment
    }

    private fun extractLoadingUnitId(engineId: String): Int {
        val engineIdPrefix = extractModule(engineId)
        if (engineIdPrefix == "note") {
            return 2;
        } else if (engineIdPrefix == "task") {
            return 3;
        }
        return 1
    }

    private fun extractModule(engineId: String) = engineId.substringBefore('_')

    override fun handleDeeplink(deeplink: Uri, engineId: String) {
        TODO("Not yet implemented")
    }

    override fun destroyEngine(engineId: String) {
//        fragments[engineId]?.detachFromFlutterEngine()

//        engineCache.get(engineId)?.let {
//            it.destroy()
//            engineCache.remove(engineId)
//        }
    }
}