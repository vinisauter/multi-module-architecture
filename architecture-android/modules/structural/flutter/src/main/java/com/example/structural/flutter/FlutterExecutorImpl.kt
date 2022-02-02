package com.example.structural.flutter

import android.content.Context
import android.net.Uri
import androidx.fragment.app.Fragment
import com.example.flutter.FlutterExecutor
import com.google.android.play.core.splitinstall.SplitInstallHelper
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager

class FlutterExecutorImpl : FlutterExecutor {
    private val engineCache: FlutterEngineCache = FlutterEngineCache.getInstance()

    private var fragments: MutableMap<String, FlutterFragment> = mutableMapOf()

    override fun getFragment(context: Context, engineId: String): Fragment {
//        SplitInstallHelper.loadLibrary(context, "app.so-${extractLoadingUnitId(engineId)}.part");

        val jni = FlutterJNI()
        val deferredComponentManager = PlayStoreDeferredComponentManager(context, jni)
        val engine = FlutterEngine(context, null, jni)
        deferredComponentManager.loadDartLibrary(
            extractLoadingUnitId(engineId),
            "split_" + extractModule(engineId)
        );

//        FlutterInjector.instance().deferredComponentManager()
//            ?.loadAssets(extractLoadingUnitId(engineId), "");

        val entrypoint = DartExecutor.DartEntrypoint.createDefault()
//        val entrypoint = DartExecutor.DartEntrypoint("","")

        engine.dartExecutor.executeDartEntrypoint(entrypoint)
        engineCache.put(engineId, engine)

        val fragment = FlutterFragment
            .withCachedEngine(engineId)
            .destroyEngineWithFragment(true)
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
        fragments[engineId]?.detachFromFlutterEngine()

        engineCache.get(engineId)?.let {
            it.destroy()
            engineCache.remove(engineId)
        }
    }
}