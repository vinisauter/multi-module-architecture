package com.example.structural

import android.app.Application
import android.content.Context
import android.injection.factory.InjectionProvider
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
    enum class ModuleNames(name: String) {
        NETWORK("network"),
        STORAGE("storage"),
        TAGGING("tagging")
    }

    fun start(app: SuperApplication) {
        provides {
            declare<SuperApplication> { app }
            declare<Application> { app }
            declare<Context> { app }

            module(ModuleNames.STORAGE.name) {
                declare<StorageExecutor> { load<StorageProvider>().executor(app) }
                shared<String>{String()}
            }
            module(ModuleNames.NETWORK.name) {
                declare<RequestExecutor> { load<NetworkingProvider>().executor(app) }
            }
            module(ModuleNames.TAGGING.name) {
                InjectionProvider.declare<TaggingExecutor> { load<TaggingProvider>().executor(app) }
            }
        }
    }
}