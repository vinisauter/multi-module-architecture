package com.example.flutter

import android.content.Context
import androidx.fragment.app.Fragment

interface FlutterExecutor {
    fun getFragment(context: Context, engineId: String): Fragment
}