package com.example.flutter

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

abstract class BaseFlutterActivity() : FlutterActivity() {

    abstract fun getSingleBindings(): BaseBindings

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        getSingleBindings().attach()
    }

    override fun onDestroy() {
        super.onDestroy()
        getSingleBindings().detach()
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return getSingleBindings().engineExecutor.engine
    }
}
