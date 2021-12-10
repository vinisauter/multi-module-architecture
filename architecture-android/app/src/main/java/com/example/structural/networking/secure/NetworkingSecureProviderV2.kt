package com.example.structural.networking.secure

import android.app.Application
import com.example.networking.RequestExecutor

interface NetworkingSecureProviderV2 {
    fun executor(app: Application): RequestExecutor
}
