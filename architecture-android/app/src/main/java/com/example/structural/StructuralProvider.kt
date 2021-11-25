package com.example.structural

import android.app.Application
import android.content.Context
import android.injection.provides
import com.auto.service.load
import com.example.app.SuperApplication
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor
import com.example.structural.networking.NetworkingProvider
import com.example.structural.storage.StorageProvider
import com.example.structural.tagging.TaggingProvider
import com.example.tagging.TaggingExecutor

@Suppress("RemoveExplicitTypeArguments")
object StructuralProvider {
    fun start(app: SuperApplication) {
        provides {

            declare<SuperApplication> { app }
            declare<Application> { app }
            declare<Context> { app }

            declare<StorageExecutor> { load<StorageProvider>().executor(app) }
            declare<RequestExecutor> { load<NetworkingProvider>().executor(app) }
            declare<TaggingExecutor> { load<TaggingProvider>().executor(app) }
        }
    }
}