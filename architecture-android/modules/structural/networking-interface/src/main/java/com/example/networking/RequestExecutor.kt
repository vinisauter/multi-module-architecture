package com.example.networking

import android.app.Application

interface RequestExecutor {
    suspend fun get(): String
    suspend fun post(): String
    suspend fun put(): String
    suspend fun delete(): String

    interface Provider {
        fun get(dependencies: Dependencies): RequestExecutor
    }
    
    interface Dependencies {
        fun getApp(): Application
    }
}