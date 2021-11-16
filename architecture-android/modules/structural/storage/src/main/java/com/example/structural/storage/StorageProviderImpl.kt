package com.example.structural.storage

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.storage.StorageExecutor

@ImplementationOf(StorageProvider::class)
class StorageProviderImpl : StorageProvider {
    override fun executor(app: Application): StorageExecutor {
        return StorageExecutorImpl(app)
    }
}
