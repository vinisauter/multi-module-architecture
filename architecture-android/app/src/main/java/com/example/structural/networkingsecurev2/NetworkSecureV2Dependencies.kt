package com.example.structural.networkingsecurev2

import android.app.Application

interface NetworkSecureV2Dependencies {
    val app: Application
    suspend fun getCertificate() : String
    suspend fun saveToken(token: String)
    suspend fun getToken() : String
}