package com.example.structural.networking

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.networking.RequestExecutor

@ImplementationOf(NetworkingProvider::class)
class NetworkingProviderImpl : NetworkingProvider {
    override fun executor(app: Application): RequestExecutor {
        return RequestExecutorImpl(app)
    }
}