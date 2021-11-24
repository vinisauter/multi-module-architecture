package com.example.journey

import android.app.Application

object JourneyLauncher {
    private lateinit var app: Application
    fun start(application: Application) {
        app = application
    }

}