@file:Suppress("RemoveExplicitTypeArguments", "MemberVisibilityCanBePrivate")

package com.example.structural

import android.app.Application
import android.content.Context
import android.injection.get
import android.injection.provides
import com.auto.service.load
import com.example.app.SuperApplication
import com.example.networking.RequestExecutor
import com.example.security.SecurityExecutor
import com.example.storage.StorageExecutor
import com.example.structural.networking.NetworkingProvider
import com.example.structural.networkingsecure.NetworkingSecureProvider
import com.example.structural.networkingsecurev2.NetworkingSecureProviderV2
import com.example.structural.security.SecurityProvider
import com.example.structural.storage.StorageProvider
import com.example.structural.tagging.TaggingProvider
import com.example.tagging.TaggingExecutor

// TODO Split Install validation to enable on-demand delivery, only install-time for now
//    <dist:delivery>
//        <dist:on-demand />
//    </dist:delivery>
object StructuralProvider {
    private fun featureFlag(flag: String): Boolean {
        return false// TODO: MOCK to structural FeatureFlag module
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
        secureRequestExecutor
    }
    val defaultSecurityExecutor: SecurityExecutor by lazy {
        load<SecurityProvider>().executor(get())
    }
    val unsecureRequestExecutor: RequestExecutor by lazy {
        load<NetworkingProvider>().executor(get())
    }
    val secureRequestExecutor: RequestExecutor by lazy {
        when {
            featureFlag("networking-version-1") -> load<NetworkingSecureProvider>().executor(get())
            else -> load<NetworkingSecureProviderV2>().executor()
        }
    }

    fun start(app: SuperApplication) {
        provides {
            declare<SuperApplication> { app }
            declare<Application> { app }
            declare<Context> { app }

            declare<StorageExecutor> { defaultStorageExecutor }
            declare<TaggingExecutor> { defaultTaggingExecutor }
            declare<RequestExecutor> { defaultRequestExecutor }
            declare<SecurityExecutor> { defaultSecurityExecutor }

            declare<RequestExecutor>(qualifier = "secure") { secureRequestExecutor }
            declare<RequestExecutor>(qualifier = "unsecure") { unsecureRequestExecutor }
        }
    }
}