package com.example.security

import android.app.Application
import com.auto.service.ImplementationOf
import com.example.structural.security.SecurityProvider

@ImplementationOf(SecurityProvider::class)
class SecurityExecutorProviderImpl : SecurityProvider {
    override fun executor(app: Application): SecurityExecutor {
        return SecurityExecutorImpl(app)
    }
}