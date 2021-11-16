package com.example.profile.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.navArgs
import com.core.extensions.deepLinkIntent
import com.core.extensions.navigate
import com.example.profile.databinding.FragmentProfileBinding

class ProfileFragment : Fragment() {
    private lateinit var binding: FragmentProfileBinding
    private val args: ProfileFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater, container, false).also { bind ->
            bind.profileButton.setOnClickListener { navigate(ProfileFragmentDirections.actionLaunchProfile()) }
            bind.exitButton.setOnClickListener { navigate(ProfileFragmentDirections.actionExit()) }

            args.queryValue?.let {
                bind.textMonitor.append("\n${it}")
            }

            deepLinkIntent?.let {
                bind.textMonitor.append("\n${it.data}")
            }
        }

        return binding.root
    }
}