package com.example.structural.networking

import com.core.extensions.longToast
import com.core.logger.Logger
import com.example.networking.RequestExecutor
import com.example.structural.networkingsecurev2.NetworkSecureV2Dependencies

class RequestExecutorSecureV2Impl(private val dependencies: NetworkSecureV2Dependencies) : RequestExecutor {
    override suspend fun get(): String {
        val description = "RequestExecutorSecureV2Impl.get" + " : " +  dependencies.getToken()
        Logger.log(description)
        dependencies.app.longToast(description)
        return "GET"
    }

    override suspend fun post(): String {
        val description = "RequestExecutorSecureV2Impl.post" + " : " + dependencies.getCertificate()
        Logger.log(description)
        dependencies.app.longToast(description)
        dependencies.saveToken("token")
        return "POST"
    }

    override suspend fun put(): String {
        val description = "RequestExecutorSecureV2Impl.put" + " : " +  dependencies.getCertificate()
        Logger.log(description)
        dependencies.app.longToast(description)
        return "PUT"
    }

    override suspend fun delete(): String {
        val description = "RequestExecutorSecureV2Impl.delete" + " : " +  dependencies.getCertificate()
        Logger.log(description)
        dependencies.app.longToast(description)
        return "DELETE"
    }
}