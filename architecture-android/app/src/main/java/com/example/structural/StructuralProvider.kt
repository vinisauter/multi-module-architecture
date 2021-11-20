package com.example.structural

import android.app.Application
import com.auto.service.lazyLoad
import com.core.analytics.Event
import com.core.analytics.ScreenName
import com.core.analytics.Tagging
import com.core.logger.Logger
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

    val tagging: Tagging by lazy {
        //TODO: Create module tagging (:modules:structural:tagging)
        object : Tagging {
            override fun sendScreenName(screenName: ScreenName) {
                Logger.log("Tagging { screenName: $screenName }")
            }

            override fun sendEvent(event: Event) {
                Logger.log("Tagging { sendEvent [ category: ${event.category}, action: ${event.action}, label: ${event.label} }")
            }
        }
    }
}