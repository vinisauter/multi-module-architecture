package com.example.storage

interface StorageExecutor {
    suspend fun get(key: String): String
    suspend fun put(key: String, value: String)
}