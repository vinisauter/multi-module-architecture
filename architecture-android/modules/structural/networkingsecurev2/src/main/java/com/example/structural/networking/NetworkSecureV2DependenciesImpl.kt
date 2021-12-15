package com.example.structural.networking

import android.app.Application
import com.example.networking.NetworkingSecureV2Dependencies
import com.example.security.SecurityExecutor
import com.example.storage.StorageExecutor
import java.util.logging.Logger

private const val TOKEN = "NetworkToken"

class NetworkSecureV2DependenciesImpl(
    override val application: Application,
    override val logger: Logger,
    private val securityExecutor: SecurityExecutor,
    private val storageExecutor: StorageExecutor,
) : NetworkingSecureV2Dependencies {

    override suspend fun getCertificate() = securityExecutor.getCertificate()

    override suspend fun saveToken(token: String) {
        storageExecutor.put(TOKEN, token)
    }

    override suspend fun getToken(): String {
        return storageExecutor.get(TOKEN)
    }
}