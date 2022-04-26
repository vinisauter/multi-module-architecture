@file:Suppress("RemoveExplicitTypeArguments", "MemberVisibilityCanBePrivate")

package com.example.structural

import android.app.Application
import com.auto.service.load
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
//  Maybe use SplitInstallManager implementation: Joy branch dynamic_delivery_on_demand
//  Or SplitInstall (navigation equivalent with interface & class instead of nav xml) from: https://github.com/vinisauter/SplitInstallAutoService/blob/master/annotations/auto/android/src/main/java/com/auto/service/dynamic/SplitInstall.kt
//    <dist:delivery>
//        <dist:on-demand />
//    </dist:delivery>

//  TODO: Can be auto generated (KSP)? maybe generate interfaces?
object StructuralProvider {
    private lateinit var app: Application

    private fun featureFlag(flag: String): Boolean {
        return false// TODO: MOCK to structural FeatureFlag module
    }

    val defaultStorageExecutor: StorageExecutor by lazy {
        val provider = load<StorageProvider>()
        provider.executor(app)
    }
    val defaultTaggingExecutor: TaggingExecutor by lazy {
        load<TaggingProvider>().executor(app)
    }
    val defaultSecurityExecutor: SecurityExecutor by lazy {
        load<SecurityProvider>().executor(app)
    }
    val defaultRequestExecutor: RequestExecutor by lazy {
        secureRequestExecutor
    }
    val unsecureRequestExecutor: RequestExecutor by lazy {
        load<NetworkingProvider>().executor(app)
    }
    val secureRequestExecutor: RequestExecutor by lazy {
        when {
            featureFlag("networking-version-1") -> load<NetworkingSecureProvider>().executor(app)
            else -> load<NetworkingSecureProviderV2>().executor(app)
        }
    }

    fun start(application: Application) {
        app = application
    }
}