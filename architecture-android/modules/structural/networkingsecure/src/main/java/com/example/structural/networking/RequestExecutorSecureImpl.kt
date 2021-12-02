package com.example.structural.networking

import android.app.Application
import com.core.extensions.longToast
import com.core.logger.Logger
import com.example.networking.RequestExecutor

class RequestExecutorSecureImpl(private val app: Application) : RequestExecutor {
    override suspend fun get(): String {
        Logger.log("RequestExecutorSecureImpl.get")
        app.longToast("RequestExecutorSecureImpl.get")
        return "GET"
    }

    override suspend fun post(): String {
        Logger.log("RequestExecutorSecureImpl.post")
        app.longToast("RequestExecutorSecureImpl.post")
        return "POST"
    }

    override suspend fun put(): String {
        Logger.log("RequestExecutorSecureImpl.put")
        app.longToast("RequestExecutorSecureImpl.put")
        return "PUT"
    }

    override suspend fun delete(): String {
        Logger.log("RequestExecutorSecureImpl.delete")
        app.longToast("RequestExecutorSecureImpl.delete")
        return "DELETE"
    }
}