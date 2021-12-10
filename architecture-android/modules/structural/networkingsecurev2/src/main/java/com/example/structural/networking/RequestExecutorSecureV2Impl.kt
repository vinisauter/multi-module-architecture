package com.example.structural.networking

import android.app.Application
import com.core.extensions.longToast
import com.core.logger.Logger
import com.example.networking.RequestExecutor

class RequestExecutorSecureV2Impl(private val app: Application) : RequestExecutor {
    override suspend fun get(): String {
        Logger.log("RequestExecutorSecureV2Impl.get")
        app.longToast("RequestExecutorSecureV2Impl.get")
        return "GET"
    }

    override suspend fun post(): String {
        Logger.log("RequestExecutorSecureV2Impl.post")
        app.longToast("RequestExecutorSecureV2Impl.post")
        return "POST"
    }

    override suspend fun put(): String {
        Logger.log("RequestExecutorSecureV2Impl.put")
        app.longToast("RequestExecutorSecureV2Impl.put")
        return "PUT"
    }

    override suspend fun delete(): String {
        Logger.log("RequestExecutorSecureV2Impl.delete")
        app.longToast("RequestExecutorSecureV2Impl.delete")
        return "DELETE"
    }
}