package androidx.fragment.app

import android.net.Uri
import android.os.Bundle
import androidx.annotation.IdRes
import androidx.lifecycle.lifecycleScope
import androidx.navigation.NavOptions
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

object FragmentExtensions {
    fun Fragment.deeplink(
        deeplink: Uri
    ) {
        val navController = findNavController()
        navController.navigate(deeplink)
    }

    fun Fragment.navigate(
        @IdRes destinationId: Int
    ) {
        val navController = findNavController()
        navController.navigate(destinationId)
    }

    fun Fragment.dynamicNavigate(
        @IdRes destinationId: Int,
        args: Bundle? = null,
        navOptions: NavOptions? = null
    ) {
        val navController = findNavController()
        val installMonitor = DynamicInstallMonitor()
        val dynamicExtras = DynamicExtras(installMonitor)
        navController.navigate(destinationId, args, navOptions, dynamicExtras)
        //installMonitor.observe(viewLifecycleOwner, statusObserver)
    }

    fun <T> Fragment.consume(flow: StateFlow<T>, operate: (value: T)->Unit) {
        lifecycleScope.launch {
            flow.collect {
                operate(it)
            }
        }
    }
}