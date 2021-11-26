package com.example.journey

import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import com.core.extensions.default
import kotlinx.coroutines.launch

class NavigationLauncher : LoaderDialog() {
    private val args: NavigationLauncherArgs by navArgs()
    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            // TODO validate args & deep link to module navigation destination
            val fromModule = args.navState?.from.default("app")

//            // TODO start LoginNavigationActivity better:
//            start<LoginNavigationActivity> {
//                if (tracking != null) {
//                    extra("tracking", tracking)
//                }
//            }
        }
    }
}