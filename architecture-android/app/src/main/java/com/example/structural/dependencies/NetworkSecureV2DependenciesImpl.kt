package com.example.structural.dependencies

import android.app.Application
import com.example.security.SecurityExecutor
import com.example.storage.StorageExecutor
import com.example.structural.networkingsecurev2.NetworkSecureV2Dependencies

const val TOKEN = "NetworkToken"

class NetworkSecureV2DependenciesImpl(
    override val app: Application,
    private val securityExecutor: SecurityExecutor,
    private val storageExecutor: StorageExecutor
) : NetworkSecureV2Dependencies {

    override suspend fun getCertificate() = securityExecutor.getCertificate()

    override suspend fun saveToken(token: String) {
        storageExecutor.put(TOKEN, token)
    }

    override suspend fun getToken(): String {
        return storageExecutor.get(TOKEN)
    }
}