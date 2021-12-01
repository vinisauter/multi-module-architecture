package com.example.profile.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.navArgs
import com.core.extensions.consume
import com.core.extensions.deepLinkIntent
import com.core.extensions.navigate
import com.example.profile.databinding.FragmentProfileBinding

class ProfileFragment : Fragment() {
    private val viewModel: ProfileViewModel by injectViewModels()
    private lateinit var binding: FragmentProfileBinding
    private val args: ProfileFragmentArgs by navArgs()
    private val deepLink by lazy { deepLinkIntent?.data }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater, container, false).apply{

            args.queryValue?.let {
                textMonitor.append("\n${it}")
            }

            deepLink?.let {
                textMonitor.append("\n${deepLink}")
            }
        }
        binding.viewModel = viewModel
        viewModel.homeButton.observe(this){
            navigate(ProfileFragmentDirections.actionLaunchHome())
        }
        viewModel.expireButton.observe(this){
            navigate(
                // TODO: redirect result
                //  Start(Reauthenticate) + didFinishDirection(this)
                //  https://medium.com/google-developer-experts/using-navigation-architecture-component-in-a-large-banking-app-ac84936a42c2
                ProfileFragmentDirections.actionReauthenticate()
            )
        }
        viewModel.loginButton.observe(this){ tracking ->
            navigate(
                ProfileFragmentDirections.actionLogin(
                    tracking = tracking
                )
            )
        }
        viewModel.exitButton.observe(this){
            navigate(ProfileFragmentDirections.actionExit())
        }

        return binding.root
    }
}