package com.example.structural.flutter

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.flutter.FlutterExecutor
//import io.flutter.FlutterInjector
//import io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager

@ImplementationOf(FlutterProvider::class)
class FlutterProviderImpl : FlutterProvider {
    override fun executor(app: Application): FlutterExecutor {
        // Create and inject a PlayStoreDeferredComponentManager, which is the default manager for
        // interacting with the Google Play Store.
//        val deferredComponentManager = PlayStoreDeferredComponentManager(app, null)
//        FlutterInjector.setInstance(
//            FlutterInjector.Builder()
//                .setDeferredComponentManager(deferredComponentManager)
//                .build()
//        )

        return FlutterExecutorImpl()
    }
}