package com.example.structural.networking.secure

import android.app.Application
import com.example.networking.RequestExecutor

interface NetworkingSecureProvider {
    fun executor(app: Application): RequestExecutor
}
