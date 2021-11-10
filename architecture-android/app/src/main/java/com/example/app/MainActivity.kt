package com.example.app

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

private const val PROFILE_CLASSNAME = "com.example.profile.ProfileHomeActivity"

class MainActivity : AppCompatActivity() {

    private val moduleProfile by lazy { "profile" }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btn_profile.setOnClickListener {
            onSuccessfulLoad(moduleProfile)
        }
    }

    private fun onSuccessfulLoad(moduleName: String) {
        when (moduleName) {
            moduleProfile -> launchActivity(PROFILE_CLASSNAME)
        }
    }

    private fun launchActivity(className: String) {
        Intent().setClassName(BuildConfig.APPLICATION_ID, className)
            .also {
                startActivity(it)
            }
    }
}
