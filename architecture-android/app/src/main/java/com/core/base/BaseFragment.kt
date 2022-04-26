package com.core.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.viewbinding.ViewBinding
import com.core.extensions.State
import com.core.extensions.consume
import com.core.extensions.getClassTypeAt
import com.core.extensions.inflateViewBinding

/**
 * Base Fragment
 *
 * Only need to provide ViewBinding and inject the ViewModel.
 *
 * */
abstract class BaseFragment<
        ViewBindingType : ViewBinding,
        ViewEvent : BaseViewEvent,
        ViewEffect : BaseViewEffect,
        ViewModelType : BaseViewModel<ViewEvent, out ViewEffect>
        > : Fragment() {
    //TODO: ViewBinding maybe not necessary
    lateinit var binding: ViewBindingType
    abstract val viewModel: ViewModelType

    private lateinit var mDefaultFactory: ViewModelProvider.Factory
    override fun getDefaultViewModelProviderFactory(): ViewModelProvider.Factory {
        if (!::mDefaultFactory.isInitialized) {
            val hostActivity = try {
                (requireActivity() as BaseHostActivity<*>)
            } catch (t: Throwable) {
                error("BaseFragment must be in a BaseHostActivity")
            }
            mDefaultFactory = BaseViewModelFactory(
                application = requireActivity().application,
                savedStateRegistryOwner = this,
                defaultArgs = arguments,
                provider = hostActivity.getDependencyProvider()
            )
        }
        return mDefaultFactory
    }

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
        afterViews(binding)
        consume(viewModel.viewEffect) {
            processEffect(it)
        }
        consume(viewModel.onStateChanged) { state: State ->
            processState(state)
        }
        return binding.root
    }

    abstract fun afterViews(binding: ViewBindingType)

    abstract fun processEffect(effect: ViewEffect)

    abstract fun processState(state: State)
//    open fun processState(state: State) {
//        when (state) {
//            State.Running -> showLoading()
//            State.Idle -> hideLoading()
//        }
//    }
//    private fun showLoading() {}
//    private fun hideLoading() {}

}

