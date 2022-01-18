package com.example.home

import android.content.Context
import com.example.flutter.BaseBindings
import com.example.flutter.FlutterEngineExecutor

interface HomeBindingsDelegate {
    fun onNext()
}

class HomeBindings(
    context: Context,
    private val delegate: HomeBindingsDelegate,
    entrypoint: String
) :
    BaseBindings(), HomeDataModelObserver {
    override var engineExecutor: FlutterEngineExecutor = FlutterEngineExecutor(context, entrypoint)

    override fun attach() {
        HomeDataModel.instance.addObserver(this)
        engineExecutor.invokeMethod("setCount", HomeDataModel.instance.counter)
        engineExecutor.setMethodCallHandler { call, result ->
            when (call.method) {
                "incrementCount" -> {
                    HomeDataModel.instance.counter = HomeDataModel.instance.counter + 1
                    result.success(null)
                }
                "next" -> {
                    this.delegate.onNext()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun detach() {
        // TODO: Uncomment after https://github.com/flutter/engine/pull/24644 is on stable.
        // engine.destroy();
        HomeDataModel.instance.removeObserver(this)
        engineExecutor.detachMethodCallHandler()
    }

    override fun onCountUpdate(newCount: Int) {
        engineExecutor.invokeMethod("setCount", newCount)
    }
}
