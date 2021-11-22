package com.example.login.ui.locator

class AppServiceLocator {
    fun plusActivityServiceLocator(): ActivityServiceLocator {
        return ActivityServiceLocator()
    }

    private object Instance {
        val instance = AppServiceLocator()
    }

    companion object {
        val instance: AppServiceLocator
            get() = Instance.instance
    }
}