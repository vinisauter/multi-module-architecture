package com.example.app

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

private const val HOME_CLASSNAME = "com.example.home.HomeActivity"
private const val PROFILE_CLASSNAME = "com.example.profile.ProfileActivity"

class MainActivity : AppCompatActivity() {

    private val moduleHome by lazy { "home" }
    private val moduleProfile by lazy { "profile" }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btn_home.setOnClickListener {
            onSuccessfulLoad(moduleHome)
        }
        btn_profile.setOnClickListener {
            onSuccessfulLoad(moduleProfile)
        }
    }

    private fun onSuccessfulLoad(moduleName: String) {
        when (moduleName) {
            moduleHome -> launchActivity(HOME_CLASSNAME)
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
