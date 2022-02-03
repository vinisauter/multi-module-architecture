package com.example.login.business.repository.local

import com.example.storage.StorageExecutor

class LoginStorage(private val storage: StorageExecutor) : LoginStorageInterface{
    override suspend fun save(userName: String) {
        storage.put("user", userName)
    }
}