package com.example.security

import android.app.Application
import android.util.Base64

class SecurityExecutorImpl(private val app: Application) : SecurityExecutor {
    override fun decrypt(text: String): String {
        return String(Base64.decode(text, Base64.DEFAULT))
    }

    override fun encrypt(text: String): String {
        return Base64.encodeToString(text.toByteArray(), Base64.DEFAULT)
    }

    override fun getCertificate(): String {
        return "Certificate"
    }
}