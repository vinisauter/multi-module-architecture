package com.example.structural.security

import android.app.Application
import com.example.security.SecurityExecutor

interface SecurityProvider {
    fun executor(app: Application): SecurityExecutor
}