package com.example.flutter

abstract class BaseBindings {
    abstract fun attach()
    abstract fun detach()
    abstract var engineExecutor: FlutterEngineExecutor
}