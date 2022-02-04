package com.example.structural.networking

import android.app.Application
import com.example.networking.RequestExecutor

interface NetworkingProvider {
    fun executor(app: Application): RequestExecutor
}
