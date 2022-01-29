package com.example.structural.flutter

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.flutter.FlutterExecutor

@ImplementationOf(FlutterProvider::class)
class FlutterProviderImpl : FlutterProvider {
    override fun executor(app: Application): FlutterExecutor {
        return FlutterExecutorImpl()
    }
}