package com.example.profile.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import androidx.navigation.fragment.navArgs
import com.core.extensions.consume
import com.core.extensions.deepLinkIntent
import com.core.extensions.navigate
import com.example.profile.databinding.FragmentProfileBinding

class ProfileFragment : Fragment() {
    private lateinit var binding: FragmentProfileBinding
    private val args: ProfileFragmentArgs by navArgs()
    private val viewModel: ProfileFragmentViewModel by injectViewModel()
    private val deepLink by lazy { deepLinkIntent?.data }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater, container, false).also { bind ->
            bind.homeButton.setOnClickListener { viewModel.onHomeClicked() }
            bind.loginButton.setOnClickListener { viewModel.onLoginClicked() }
            bind.reauthenticateButton.setOnClickListener { viewModel.onReauthenticateClicked() }
            bind.exitButton.setOnClickListener { viewModel.onExitClicked() }

            args.queryValue?.let {
                bind.textMonitor.append("\n${it}")
            }

            deepLink?.let {
                bind.textMonitor.append("\n${deepLink}")
            }

            consume(viewModel.onActionCompleted) { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }

        return binding.root
    }
}