package com.example.structural.networking

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.networking.RequestExecutor
import com.example.structural.networking.secure.NetworkingSecureProvider

@ImplementationOf(NetworkingSecureProvider::class)
class NetworkingSecureProviderImpl : NetworkingSecureProvider {
    override fun executor(app: Application): RequestExecutor {
        return RequestExecutorSecureImpl(app)
    }
}