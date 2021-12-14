package com.example.security

import android.app.Application

class SecurityExecutorImpl(private val app: Application) : SecurityExecutor {
    override fun decrypt(text: String): String {
        TODO("Not yet implemented")
    }

    override fun encrypt(text: String): String {
        TODO("Not yet implemented")
    }

    override fun getCertificate(): String {
        TODO("Not yet implemented")
    }
}