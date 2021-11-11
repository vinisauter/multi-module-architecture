package com.example.profile

import android.content.Context
import com.example.flutter.BaseBindings
import com.example.flutter.FlutterEngineExecutor

interface ProfileBindingsDelegate {
    fun onNext()
}

class ProfileBindings(
    context: Context,
    private val delegate: ProfileBindingsDelegate,
    entrypoint: String
) :
    BaseBindings(), ProfileDataModelObserver {
    override var engineExecutor: FlutterEngineExecutor = FlutterEngineExecutor(context, entrypoint)

    override fun attach() {
        ProfileDataModel.instance.addObserver(this)
        engineExecutor.invokeMethod("setCount", ProfileDataModel.instance.counter)
        engineExecutor.setMethodCallHandler { call, result ->
            when (call.method) {
                "incrementCount" -> {
                    ProfileDataModel.instance.counter = ProfileDataModel.instance.counter + 1
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
        ProfileDataModel.instance.removeObserver(this)
        engineExecutor.detachMethodCallHandler()
    }

    override fun onCountUpdate(newCount: Int) {
        engineExecutor.invokeMethod("setCount", newCount)
    }
}
