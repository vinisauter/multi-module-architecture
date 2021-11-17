package com.navigationapp

import androidx.annotation.IdRes
import androidx.fragment.app.Fragment
import androidx.navigation.NavController
import androidx.navigation.NavDirections
import androidx.navigation.fragment.NavHostFragment
import androidx.viewbinding.ViewBinding

class NavigatorController(fragment: Fragment?) : Navigator {

    private var viewBinding: ViewBinding? = null
    private var navController: NavController? = null

    init {
        navController = fragment?.let { NavHostFragment.findNavController(it) }
    }

    override fun navigateUp() {
        navController?.navigateUp()
    }

    override fun navigate(@IdRes resId: Int) {
        navController?.navigate(resId)
    }

    override fun navigate(directions: NavDirections) {
        navController?.navigate(directions)
    }

    override fun setBinding(binding: ViewBinding?) {
        viewBinding = binding
    }

    override fun setAction(binding: ViewBinding?) {
        TODO("Not yet implemented")
    }

    override fun setExtras(binding: ViewBinding?) {
        TODO("Not yet implemented")
    }

    override fun setDeepLink(binding: ViewBinding?) {
        TODO("Not yet implemented")
    }

}


