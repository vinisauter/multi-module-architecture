package com.example.profile.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.navArgs
import com.core.extensions.deepLinkIntent
import com.core.extensions.navigate
import com.example.journey.login.tracking.LoginTracking
import com.example.profile.databinding.FragmentProfileBinding
import com.example.tagging.Tagging.Event
import com.example.tagging.Tagging.ScreenName

class ProfileFragment : Fragment() {
    private lateinit var binding: FragmentProfileBinding
    private val args: ProfileFragmentArgs by navArgs()
    private val deepLink by lazy { deepLinkIntent?.data }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater, container, false).also { bind ->
            bind.profileButton.setOnClickListener { navigate(ProfileFragmentDirections.actionLaunchHome()) }
            bind.loginButton.setOnClickListener {
                // TODO extract to file
                val tracking = LoginTracking(
                    //LoginFragment
                    loginScreenName = ScreenName("profile_login"),
                    loginClickAuthEvent = Event("profile_login", "click", "auth"),
                    loginAuthSucceededEvent = Event("profile_login", "auth", "succeeded"),
                    loginAuthFailedEvent = Event("profile_login", "auth", "failed"),
                    loginClickForgotPasswordEvent = Event(
                        "profile_login",
                        "click",
                        "forgot_password"
                    ),
                    //ForgotPasswordFragment
                    forgotPasswordScreenName = ScreenName("profile_forgot_password"),
                    forgotPasswordClickExitEvent = Event(
                        "profile_forgot_password",
                        "click",
                        "exit"
                    ),
                )

                navigate(
                    ProfileFragmentDirections.actionLogin(
                        tracking = tracking
                    )
                )
            }
            bind.reauthenticateButton.setOnClickListener {
                navigate(
                    // TODO: redirect result
                    //  Start(Reauthenticate) + didFinishDirection(this)
                    //  https://medium.com/google-developer-experts/using-navigation-architecture-component-in-a-large-banking-app-ac84936a42c2
                    ProfileFragmentDirections.actionReauthenticate()
                )
            }
            bind.exitButton.setOnClickListener { navigate(ProfileFragmentDirections.actionExit()) }

            args.queryValue?.let {
                bind.textMonitor.append("\n${it}")
            }

            deepLink?.let {
                bind.textMonitor.append("\n${deepLink}")
            }
        }

        return binding.root
    }
}