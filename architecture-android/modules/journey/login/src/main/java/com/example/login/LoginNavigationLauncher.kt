package com.example.login

import android.content.Intent
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.navArgs
import com.core.base.LoaderDialog
import com.core.extensions.deepLinkUri
import com.core.extensions.default
import com.example.journey.login.tracking.LoginTracking
import kotlinx.coroutines.launch

//https://medium.com/google-developer-experts/using-navigation-architecture-component-in-a-large-banking-app-ac84936a42c2
class LoginNavigationLauncher : LoaderDialog() {
    private val args: LoginNavigationLauncherArgs by navArgs()
    private val deepLink by deepLinkUri()
    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            // TODO validate args & deep link to module navigation destination
            val tracking = args.loginCustomDependencies?.tracking.default(LoginTracking())

            // TODO start LoginNavigationActivity better:
            startActivity(Intent(requireContext(), LoginNavigationActivity::class.java))
        }
    }
}
