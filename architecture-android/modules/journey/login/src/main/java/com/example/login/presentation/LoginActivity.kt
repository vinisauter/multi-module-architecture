package com.example.login.presentation

import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import com.example.core.NextBaseActivity
import com.example.login.LoginLauncher
import com.example.login.R
import com.example.login.databinding.ActivityLoginBinding
import kotlinx.coroutines.launch
import org.koin.androidx.scope.activityScope
import org.koin.androidx.scope.scope
import org.koin.androidx.viewmodel.ext.android.viewModel

class LoginActivity : NextBaseActivity<ActivityLoginBinding, LoginViewModel>() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        LoginLauncher()

        mViewDataBinding.run {
            signInButton.setOnClickListener {
                lifecycleScope.launch {
                    mViewModel.login(
                        emailTextField.editText?.text.toString(),
                        passwordTextField.editText?.text.toString()
                    )
                }
            }
        }
    }

    override val mLayoutId: Int = R.layout.activity_login

    override val mViewModel: LoginViewModel by viewModel()

}