package com.example.login.core.repository.local

import com.example.storage.StorageExecutor

class LoginStorage(private val storage: StorageExecutor) {
    suspend fun save(userName: String) {
        storage.put("user", userName)
    }
}