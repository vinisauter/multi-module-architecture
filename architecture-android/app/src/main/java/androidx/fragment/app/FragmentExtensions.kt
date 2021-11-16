package androidx.fragment.app

import android.os.Bundle
import androidx.annotation.IdRes
import androidx.navigation.NavOptions
import androidx.navigation.dynamicfeatures.DynamicExtras
import androidx.navigation.dynamicfeatures.DynamicInstallMonitor
import androidx.navigation.fragment.findNavController

object FragmentExtensions {
    fun Fragment.navigate(
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
}