package com.example.networking

interface RequestExecutor {
    suspend fun get(): String
    suspend fun post(): String
    suspend fun put(): String
    suspend fun delete(): String
}