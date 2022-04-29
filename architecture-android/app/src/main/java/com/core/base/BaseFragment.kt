package com.core.base

import android.os.Bundle
import android.view.View
import androidx.annotation.LayoutRes
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.core.extensions.State
import com.core.extensions.consume

/**
 * Base Fragment
 *
 * Only need to provide ViewBinding and inject the ViewModel.
 *
 * */
abstract class BaseFragment<
        ViewEvent : BaseViewEvent,
        ViewEffect : BaseViewEffect,
        ViewModelType : BaseViewModel<ViewEvent, out ViewEffect>
        >(@LayoutRes contentLayoutId: Int = 0) : Fragment(contentLayoutId) {
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

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        afterViews(view)
        consume(viewModel.viewEffect) {
            processEffect(it)
        }
        consume(viewModel.onStateChanged) { state: State ->
            processState(state)
        }
    }

    abstract fun afterViews(view: View)

    abstract fun processEffect(effect: ViewEffect)

    abstract fun processState(state: State)
// TODO: default loader?
//    open fun processState(state: State) {
//        when (state) {
//            State.Running -> showLoading()
//            State.Idle -> hideLoading()
//        }
//    }
//    private fun showLoading() {}
//    private fun hideLoading() {}

}

