package com.example.networking

import android.app.Application
import java.util.logging.Logger

interface NetworkingSecureV2Dependencies {
    val application: Application
    val logger: Logger
    suspend fun getCertificate(): String
    suspend fun saveToken(token: String)
    suspend fun getToken(): String
}