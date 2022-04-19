package com.example.login.presentation

import android.app.Application
import android.os.Bundle
import androidx.fragment.app.viewModels
import androidx.lifecycle.AbstractSavedStateViewModelFactory
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.navigation.NavDirections
import androidx.savedstate.SavedStateRegistryOwner
import com.core.base.BaseFragment
import com.core.base.LoaderDialog
import com.core.extensions.State
import com.core.extensions.consume
import com.core.extensions.navigate
import com.example.journey.login.tracking.LoginTracking
import com.example.login.core.Login
import com.example.login.core.repository.local.LoginStorage
import com.example.login.core.repository.remote.LoginApi
import com.example.login.databinding.FragmentLoginBinding
import com.example.structural.StructuralProvider
import com.example.tagging.TaggingExecutor

class LoginFragment : BaseFragment<FragmentLoginBinding, LoginFragmentViewModel>() {

    lateinit var loginFragmentViewModelFactory: LoginFragmentViewModelFactory

    override val viewModel: LoginFragmentViewModel by viewModels {
        loginFragmentViewModelFactory
    }

    override fun afterViews(binding: FragmentLoginBinding) {
        with(StructuralProvider) {
            loginFragmentViewModelFactory = LoginFragmentViewModelFactory(
                requireContext().applicationContext as Application,
                owner = this@LoginFragment,
                defaultArgs = null,
                tagging = defaultTaggingExecutor,
                useCase = LoginFragmentUseCases(
                    Login(
                        LoginApi(
                            unsecureRequestExecutor,
                            secureRequestExecutor,
                        ),
                        LoginStorage(defaultStorageExecutor),
                    )
                ),
                tracking = LoginTracking()
            )
        }

        viewModel.onLoginViewCreated()

        binding.viewModel = viewModel

        consume(viewModel.onActionCompleted) { navDirection: NavDirections ->
            navigate(navDirection)
        }
        consume(viewModel.onStateChanged) { state: State ->
            when (state) {
                State.Running -> showLoading()
                State.Idle -> hideLoading()
            }
        }
    }

    private fun hideLoading() {
        loader?.dismiss()
        loader = null
    }

    var loader: LoaderDialog? = null
    private fun showLoading() {
        if (loader == null) loader = LoaderDialog().also {
            it.show(childFragmentManager, "login-loader")
        }
    }

}

class LoginFragmentViewModelFactory constructor(
    private val application: Application,
    private val owner: SavedStateRegistryOwner,
    private val defaultArgs: Bundle? = null,
    private val tagging: TaggingExecutor,
    private val useCase: LoginFragmentUseCases,
    private val tracking: LoginTracking
) : AbstractSavedStateViewModelFactory(owner, defaultArgs) {

    override fun <T : ViewModel?> create(
        key: String,
        modelClass: Class<T>,
        handle: SavedStateHandle
    ): T {
        return if (modelClass.isAssignableFrom(LoginFragmentViewModel::class.java)) {
            LoginFragmentViewModel(
                application,
                handle,
                tagging,
                useCase,
                tracking
            ) as T
        } else {
            throw IllegalArgumentException("ViewModel Not Found")
        }
    }
}

