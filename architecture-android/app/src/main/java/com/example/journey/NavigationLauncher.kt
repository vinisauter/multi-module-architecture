package com.example.journey

import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import com.core.extensions.deepLinkUri
import kotlinx.coroutines.launch

class NavigationLauncher : LoaderDialog() {
    private val args: NavigationLauncherArgs by navArgs()
    private val deepLink by deepLinkUri()
    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
//            // TODO validate args & deep link to module navigation destination
//            val tracking = args.loginCustomDependencies?.tracking.default(LoginTracking())
//            provides { declare<LoginTracking> { tracking } }
//            // TODO start LoginNavigationActivity better:
//            startActivity(LoginNavigationActivity::class.intent())
        }
    }
}
