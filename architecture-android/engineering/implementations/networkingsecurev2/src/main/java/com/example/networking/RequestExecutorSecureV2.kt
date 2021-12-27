package com.example.networking

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.widget.Toast

class RequestExecutorSecureV2(private val dependencies: NetworkingSecureV2Dependencies) :
    RequestExecutor {
    override suspend fun get(): String {
        val description = "RequestExecutorSecureV2.get: ${dependencies.getToken()}"
        dependencies.logger.info(description)
        dependencies.application.longToast(description)
        return "GET"
    }

    override suspend fun post(): String {
        val description = "RequestExecutorSecureV2.post: ${dependencies.getCertificate()}"
        dependencies.logger.info(description)
        dependencies.application.longToast(description)
        dependencies.saveToken("token")
        return "POST"
    }

    override suspend fun put(): String {
        val description = "RequestExecutorSecureV2.put: ${dependencies.getCertificate()}"
        dependencies.logger.info(description)
        dependencies.application.longToast(description)
        return "PUT"
    }

    override suspend fun delete(): String {
        val description = "RequestExecutorSecureV2.delete: ${dependencies.getCertificate()}"
        dependencies.logger.info(description)
        dependencies.application.longToast(description)
        return "DELETE"
    }

    private fun Context.longToast(text: CharSequence) {
        Handler(Looper.getMainLooper()).post {
            Toast.makeText(this, text, Toast.LENGTH_LONG).show()
        }
    }
}