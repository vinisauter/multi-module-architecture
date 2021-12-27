package com.core.extensions

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.viewbinding.ViewBinding

fun <T : ViewBinding> viewBindingInflate(
    clazz: Class<T>,
    inflater: LayoutInflater,
    parent: ViewGroup?
): T {
    val method = clazz.getDeclaredMethod(
        "inflate",
        LayoutInflater::class.java,
        ViewGroup::class.java,
        Boolean::class.java
    )
    @Suppress("UNCHECKED_CAST")
    return method.invoke(null, inflater, parent, false) as T
}

