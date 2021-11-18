package com.example.app.base

import android.os.Bundle
import android.view.View
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.launch

abstract class LauncherFragment() : BaseFragment(), ModuleExecutor {
    protected abstract val launcher: BaseLauncher

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        lifecycleScope.launch {
            launcher.start()
            execute()
        }
    }

}