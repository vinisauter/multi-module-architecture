package com.core.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.ViewDataBinding
import androidx.viewbinding.ViewBinding
import com.core.extensions.getClassTypeAt
import com.core.extensions.inflateViewBinding

/**
 * Base Fragment
 *
 * Only need to provide ViewBinding and inject the ViewModel.
 *
 * */
abstract class BaseBindingFragment<
        ViewBindingType : ViewBinding,
        ViewEvent : BaseViewEvent,
        ViewEffect : BaseViewEffect,
        ViewModelType : BaseViewModel<ViewEvent, out ViewEffect>
        > : BaseFragment<ViewEvent, ViewEffect, ViewModelType>() {
    lateinit var binding: ViewBindingType

    open fun inflateViewBinding(
        inflater: LayoutInflater,
        container: ViewGroup?
    ): ViewBindingType {
        val viewBindingClass: Class<ViewBindingType> = getClassTypeAt(0)
        binding = inflateViewBinding(viewBindingClass, inflater, container)
//      if data binding is enabled
        if (binding is ViewDataBinding) {
            val viewDataBinding = (binding as ViewDataBinding)
            viewDataBinding.lifecycleOwner = viewLifecycleOwner
            viewDataBinding.executePendingBindings()
        }
        return binding
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = inflateViewBinding(inflater, container)
        return binding.root
    }

    override fun afterViews(view: View) {
        afterViews(binding)
    }

    abstract fun afterViews(binding: ViewBindingType)
}

