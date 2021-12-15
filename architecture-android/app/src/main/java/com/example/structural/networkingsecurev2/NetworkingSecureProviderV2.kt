package com.example.structural.networkingsecurev2

import com.example.networking.RequestExecutor

interface NetworkingSecureProviderV2 {
    fun executor(dependencies: NetworkSecureV2Dependencies): RequestExecutor
}
