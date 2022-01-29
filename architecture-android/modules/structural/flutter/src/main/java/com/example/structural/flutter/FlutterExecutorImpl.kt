package com.example.structural.flutter

import android.content.Context
import androidx.fragment.app.Fragment
import com.example.flutter.FlutterExecutor
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor

class FlutterExecutorImpl : FlutterExecutor {

    private val engineCache: FlutterEngineCache = FlutterEngineCache.getInstance()

    override fun getFragment(context: Context, engineId: String): Fragment {
        val engine = FlutterEngine(context)
//        engineId = engine.hashCode().toString()

        FlutterJNI()

        engine.navigationChannel.setInitialRoute("")
//        engine.
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        engineCache.put(engineId, engine)

        return FlutterFragment
            .withCachedEngine(engineId)
            .destroyEngineWithFragment(true)
            .build()
    }
}