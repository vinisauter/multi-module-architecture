package com.example.structural.flutter

import android.app.Application
import com.example.flutter.FlutterExecutor

interface FlutterProvider {
    fun executor(app: Application): FlutterExecutor
}