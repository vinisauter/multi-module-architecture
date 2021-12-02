@file:Suppress("RemoveExplicitTypeArguments", "MemberVisibilityCanBePrivate")

package com.example.structural

import android.app.Application
import android.content.Context
import android.injection.get
import android.injection.provides
import com.auto.service.load
import com.example.app.SuperApplication
import com.example.networking.RequestExecutor
import com.example.storage.StorageExecutor
import com.example.structural.networking.NetworkingProvider
import com.example.structural.networking.secure.NetworkingSecureProvider
import com.example.structural.storage.StorageProvider
import com.example.structural.tagging.TaggingProvider
import com.example.tagging.TaggingExecutor

object StructuralProvider {
    fun start(app: SuperApplication) {
        provides {
            declare<SuperApplication> { app }
            declare<Application> { app }
            declare<Context> { app }

            declare<StorageExecutor> { defaultStorageExecutor }
            declare<TaggingExecutor> { defaultTaggingExecutor }

            declare<RequestExecutor> {//default
                when {
                    featureFlag("executor-version-1") -> secureRequestExecutor
                    else -> unsecureRequestExecutor
                }
            }
            declare<RequestExecutor>(qualifier = "secure") { secureRequestExecutor }
            declare<RequestExecutor>(qualifier = "unsecure") { unsecureRequestExecutor }
        }
    }

    private fun featureFlag(flag: String): Boolean {
        return true
    }

    val defaultStorageExecutor by lazy {
        val app: Application = get()
//        val provider = ServiceLoader.load(
//            StorageProvider::class.java,
//            StorageProvider::class.java.classLoader
//        )
        val provider = load<StorageProvider>()
        provider.executor(app)
    }
    val unsecureRequestExecutor by lazy {
        val app: Application = get()
        val provider = load<NetworkingProvider>()
        provider.executor(app)
    }
    val secureRequestExecutor by lazy {
        val app: Application = get()
        val provider = load<NetworkingSecureProvider>()
        provider.executor(app)
    }
    val defaultTaggingExecutor by lazy {
        load<TaggingProvider>().executor(get())
    }
}