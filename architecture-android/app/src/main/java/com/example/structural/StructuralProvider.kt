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
    private fun featureFlag(flag: String): Boolean {
        return true// TODO: MOCK to structural FeatureFlag module
    }

    val defaultStorageExecutor: StorageExecutor by lazy {
//        val provider = ServiceLoader.load(
//            StorageProvider::class.java,
//            StorageProvider::class.java.classLoader
//        )
        val provider = load<StorageProvider>()
        val app: Application = get()
        provider.executor(app)
//        load<StorageProvider>().executor(get())
    }
    val defaultTaggingExecutor: TaggingExecutor by lazy {
        load<TaggingProvider>().executor(get())
    }
    val defaultRequestExecutor: RequestExecutor by lazy {
        when {
            featureFlag("executor-version-1") -> secureRequestExecutor
            else -> unsecureRequestExecutor
        }
    }
    val unsecureRequestExecutor: RequestExecutor by lazy {
        load<NetworkingProvider>().executor(get())
    }
    val secureRequestExecutor: RequestExecutor by lazy {
        load<NetworkingSecureProvider>().executor(get())
    }

    fun start(app: SuperApplication) {
        provides {
            declare<SuperApplication> { app }
            declare<Application> { app }
            declare<Context> { app }

            declare<StorageExecutor> { defaultStorageExecutor }
            declare<TaggingExecutor> { defaultTaggingExecutor }
            declare<RequestExecutor> { defaultRequestExecutor }

            declare<RequestExecutor>(qualifier = "secure") { secureRequestExecutor }
            declare<RequestExecutor>(qualifier = "unsecure") { unsecureRequestExecutor }
        }
    }
}