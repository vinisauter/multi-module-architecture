package com.core.base

import android.injection.Module

interface BaseProvider {
    fun applyTo(module: Module) {
        module.dependencies()
    }

    fun Module.dependencies()
}