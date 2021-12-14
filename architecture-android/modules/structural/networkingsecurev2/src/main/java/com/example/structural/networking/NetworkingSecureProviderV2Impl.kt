package com.example.structural.networking

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.networking.RequestExecutor
import com.example.structural.networkingsecurev2.NetworkingSecureProviderV2

@ImplementationOf(NetworkingSecureProviderV2::class)
class NetworkingSecureProviderV2Impl : NetworkingSecureProviderV2 {
    override fun executor(app: Application): RequestExecutor {
        return RequestExecutorSecureV2Impl(app)
    }
}