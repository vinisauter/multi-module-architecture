package com.core.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import androidx.viewbinding.ViewBinding
import java.lang.reflect.ParameterizedType

/**
 * Base Fragment
 *
 * Only need to provide ViewBinding and inject the ViewModel.
 *
 * */
abstract class BaseFragment<ViewBindingType : ViewBinding, ViewModelType : BaseViewModel> :
    Fragment() {
    lateinit var binding: ViewBindingType
    abstract val viewModel: ViewModelType

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val viewBindingClass: Class<ViewBindingType> = getClassTypeAt(0)
        binding = viewBindingInflate(viewBindingClass, inflater, container)
        if (binding is ViewDataBinding) {
            val viewDataBinding = (binding as ViewDataBinding)
            viewDataBinding.lifecycleOwner = this
            viewDataBinding.executePendingBindings()
        }
        afterViews(binding)
        return binding.root
    }

    abstract fun afterViews(binding: ViewBindingType)

    private fun <T : ViewBinding> viewBindingInflate(
        clazz: Class<T>,
        inflater: LayoutInflater,
        parent: ViewGroup?
    ): T {
        val method = clazz.getDeclaredMethod(
            "inflate",
            LayoutInflater::class.java,
            ViewGroup::class.java,
            Boolean::class.java //boolean
        )
        @Suppress("UNCHECKED_CAST")
        return method.invoke(null, inflater, parent, false) as T
    }

    private fun <Type> Any.getClassTypeAt(position: Int): Class<Type> {
        @Suppress("UNCHECKED_CAST")
        return (this::class.java.genericSuperclass as ParameterizedType).actualTypeArguments[position] as Class<Type>
    }
}

