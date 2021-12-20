package com.core.base

import android.app.Application
import android.content.ContextWrapper
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import androidx.lifecycle.InjectionViewModelFactory
import androidx.lifecycle.ViewModelProvider
import androidx.viewbinding.ViewBinding
import com.core.extensions.getClassTypeAt
import com.core.extensions.viewBindingInflate

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

    private lateinit var mDefaultFactory: ViewModelProvider.Factory
    override fun getDefaultViewModelProviderFactory(): ViewModelProvider.Factory {
        if (!::mDefaultFactory.isInitialized) {
            var application: Application? = null
            var appContext = requireContext().applicationContext
            while (appContext is ContextWrapper) {
                if (appContext is Application) {
                    application = appContext
                    break
                }
                appContext = appContext.baseContext
            }
            mDefaultFactory = InjectionViewModelFactory(
                application,
                this,
                arguments
            )
        }
        return mDefaultFactory
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val viewBindingClass: Class<ViewBindingType> = getClassTypeAt(0)
        binding = viewBindingInflate(viewBindingClass, inflater, container)
        if (binding is ViewDataBinding) {
            val viewDataBinding = (binding as ViewDataBinding)
            viewDataBinding.lifecycleOwner = viewLifecycleOwner
            viewDataBinding.executePendingBindings()
        }
        afterViews(binding)
        return binding.root
    }

    abstract fun afterViews(binding: ViewBindingType)
}

