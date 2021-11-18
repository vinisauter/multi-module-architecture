package com.example.login.view

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.FragmentExtensions.consume
import androidx.fragment.app.viewModels
import com.example.app.base.LauncherFragment
import com.example.login.LoginLauncher
import com.example.login.databinding.FragmentLoginBinding
import com.example.login.viewmodel.LoginViewModel

/**
 * A simple [Fragment] subclass as the default destination in the navigation.
 */
class LoginFragment : LauncherFragment() {
    override val launcher = LoginLauncher
    private val viewModel: LoginViewModel by viewModels()
    private lateinit var binding: FragmentLoginBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentLoginBinding.inflate(inflater, container, false)
        binding.viewModel = viewModel
        return binding.root

    }

    override fun onStart() {
        super.onStart()
        consume(viewModel.btLogin) { success ->
            if (success) {
                Log.w("PRESSED", "loginButton")
            }
        }
    }

    override fun execute() {}
}