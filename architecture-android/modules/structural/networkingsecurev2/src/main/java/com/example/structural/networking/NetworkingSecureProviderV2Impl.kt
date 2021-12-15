package com.example.structural.networking

import com.auto.service.ImplementationOf
import com.example.networking.RequestExecutor
import com.example.structural.networkingsecurev2.NetworkSecureV2Dependencies
import com.example.structural.networkingsecurev2.NetworkingSecureProviderV2

@ImplementationOf(NetworkingSecureProviderV2::class)
class NetworkingSecureProviderV2Impl : NetworkingSecureProviderV2 {
    override fun executor(dependencies: NetworkSecureV2Dependencies): RequestExecutor {
        return RequestExecutorSecureV2Impl(dependencies)
    }
}