package com.example.security

interface SecurityExecutor {
    fun getCertificate() : String
    fun decrypt(text: String) : String
    fun encrypt(text: String) : String
}