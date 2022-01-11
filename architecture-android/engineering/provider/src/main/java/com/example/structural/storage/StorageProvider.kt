package com.example.structural.storage

import android.app.Application
import com.example.storage.StorageExecutor

interface StorageProvider {
    fun executor(app: Application): StorageExecutor
}
