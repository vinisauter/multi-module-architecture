package com.example.structural.networking

import android.app.Application
import com.core.extensions.longToast
import com.core.logger.Logger
import com.example.networking.RequestExecutor

class RequestExecutorImpl(private val app: Application) : RequestExecutor {
    override suspend fun get(): String {
        Logger.log("RequestExecutorImpl.get")
        app.longToast("RequestExecutorImpl.get")
        return "GET"
    }

    override suspend fun post(): String {
        Logger.log("RequestExecutorImpl.post")
        app.longToast("RequestExecutorImpl.post")
        return "POST"
    }

    override suspend fun put(): String {
        Logger.log("RequestExecutorImpl.put")
        app.longToast("RequestExecutorImpl.put")
        return "PUT"
    }

    override suspend fun delete(): String {
        Logger.log("RequestExecutorImpl.delete")
        app.longToast("RequestExecutorImpl.delete")
        return "DELETE"
    }
}