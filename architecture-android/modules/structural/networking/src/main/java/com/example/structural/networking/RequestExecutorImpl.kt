package com.example.structural.networking

import android.app.Application
import com.example.app.longToast
import com.example.networking.RequestExecutor

class RequestExecutorImpl(private val app: Application) : RequestExecutor {
    override suspend fun get(): String {
        app.longToast("RequestExecutorImpl.get")
        return "GET"
    }

    override suspend fun post(): String {
        app.longToast("RequestExecutorImpl.post")
        return "POST"
    }

    override suspend fun put(): String {
        app.longToast("RequestExecutorImpl.put")
        return "PUT"
    }

    override suspend fun delete(): String {
        app.longToast("RequestExecutorImpl.delete")
        return "DELETE"
    }

    companion object Provider : RequestExecutor.Provider {
        override fun get(dependencies: RequestExecutor.Dependencies): RequestExecutor {
            return RequestExecutorImpl(dependencies.getApp())
        }
    }
}