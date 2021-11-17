package com.navigationapp

import androidx.annotation.IdRes
import androidx.annotation.NonNull
import androidx.navigation.NavDirections
import androidx.viewbinding.ViewBinding

interface Navigator {
    fun navigateUp()
    fun navigate(@IdRes resId: Int)
    fun navigate(@NonNull directions: NavDirections)
    fun setBinding(binding: ViewBinding?)
    fun setAction(binding: ViewBinding?)
    fun setExtras(binding: ViewBinding?)
    fun setDeepLink(binding: ViewBinding?)
}