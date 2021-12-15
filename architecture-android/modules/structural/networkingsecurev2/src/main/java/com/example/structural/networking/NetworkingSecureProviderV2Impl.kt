package com.example.structural.networking

import android.injection.get
import com.auto.service.ImplementationOf
import com.core.logger.Logger
import com.example.networking.RequestExecutor
import com.example.networking.RequestExecutorSecureV2
import com.example.structural.StructuralProvider
import com.example.structural.networkingsecurev2.NetworkingSecureProviderV2

@ImplementationOf(NetworkingSecureProviderV2::class)
class NetworkingSecureProviderV2Impl : NetworkingSecureProviderV2 {
// TODO: security modules can be private to app?
//    val security: SecurityExecutor by lazy {
//        load<SecurityProvider>().executor(get())
//    }
    override fun executor(): RequestExecutor {
        return RequestExecutorSecureV2(
            NetworkSecureV2DependenciesImpl(
                application = get(),
                logger = Logger.logger,
                securityExecutor = StructuralProvider.defaultSecurityExecutor,
                storageExecutor = StructuralProvider.defaultStorageExecutor
            )
        )
    }
}