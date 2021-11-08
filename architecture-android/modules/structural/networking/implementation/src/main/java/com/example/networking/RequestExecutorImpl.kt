package com.example.networking

class RequestExecutorImpl : RequestExecutor {
    override suspend fun get(): String {
        return "GET"
    }

    override suspend fun post(): String {
        return "POST"
    }

    override suspend fun put(): String {
        return "PUT"
    }

    override suspend fun delete(): String {
        return "DELETE"
    }
}