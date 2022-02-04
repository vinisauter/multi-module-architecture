package com.example.structural.networkingsecurev2

import android.app.Application
import com.example.networking.RequestExecutor

interface NetworkingSecureProviderV2 {
    fun executor(application: Application): RequestExecutor
}
