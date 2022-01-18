package com.example.structural.storage

import android.app.Application
import com.example.app.longToast
import com.example.storage.StorageExecutor

class StorageExecutorImpl(private val app: Application) : StorageExecutor {
    override suspend fun get(key: String): String {
        app.longToast("StorageExecutorImpl.get($key)")
        return "get"
    }

    override suspend fun put(key: String, value: String) {
        app.longToast("StorageExecutorImpl.put($key, $value)")
    }

}
