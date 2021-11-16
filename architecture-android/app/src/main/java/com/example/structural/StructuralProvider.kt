package com.example.structural

import android.app.Application
import com.auto.service.lazyLoad
import com.example.structural.networking.NetworkingProvider
import com.example.structural.storage.StorageProvider

object StructuralProvider {
    private lateinit var app: Application
    fun start(application: Application) {
        app = application
    }

    private val networkingProvider by lazyLoad<NetworkingProvider>()
    val networking by lazy {
        networkingProvider.executor(app)
    }

    private val storageProvider by lazyLoad<StorageProvider>()
    val storage by lazy {
        storageProvider.executor(app)
    }
}