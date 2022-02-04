package com.example.flutter

import android.content.Context
import android.net.Uri
import androidx.fragment.app.Fragment

interface FlutterExecutor {
    fun getFragment(context: Context, moduleName: String, engineId: String): Fragment
    fun handleDeeplink(deeplink: Uri, engineId: String)
    fun destroyEngine(engineId: String)
}