package com.example.journey

import android.app.Application
import com.auto.service.lazyLoad
import com.example.journey.home.HomeLauncher
import com.example.journey.profile.ProfileLauncher

object JourneyLauncher {
    private lateinit var app: Application
    fun start(application: Application) {
        app = application
    }

//    val loginLauncher by lazyLoad<LoginLauncher>()
    val homeLauncher by lazyLoad<HomeLauncher>()
    val profileLauncher by lazyLoad<ProfileLauncher>()
}