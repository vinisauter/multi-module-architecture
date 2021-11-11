package com.example.profile

import android.content.Context
import android.content.Intent
import android.os.Bundle
import com.example.flutter.EngineBindings
import com.example.flutter.EngineBindingsDelegate
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

/**
 * This is an Activity that displays one instance of Flutter.
 *
 * EngineBindings is used to bridge communication between the Flutter instance and the DataModel.
 */
class SingleFlutterActivity : FlutterActivity(), EngineBindingsDelegate {
    private val engineBindings: EngineBindings by lazy {
        EngineBindings(activity = this, delegate = this, entrypoint = "profileSingleRoute")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        engineBindings.attach()
    }

    override fun onDestroy() {
        super.onDestroy()
        engineBindings.detach()
    }

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return engineBindings.engine
    }

    override fun onNext() {
        val flutterIntent = Intent(this, ProfileActivity::class.java)
        startActivity(flutterIntent)
    }
}
