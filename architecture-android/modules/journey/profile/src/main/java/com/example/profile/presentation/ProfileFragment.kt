package com.example.profile.presentation

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.NavDirections
import androidx.navigation.fragment.navArgs
import com.core.base.BaseViewModelFactory
import com.core.extensions.consume
import com.core.extensions.deepLinkIntent
import com.core.extensions.navigate
import com.example.profile.databinding.FragmentProfileBinding

class ProfileFragment : Fragment() {
    private lateinit var binding: FragmentProfileBinding
    private val args: ProfileFragmentArgs by navArgs()
    private val viewModel: ProfileFragmentViewModel by viewModels {
        BaseViewModelFactory(
            application = requireActivity().application,
            savedStateRegistryOwner = this,
            defaultArgs = arguments,
            provider = BaseViewModelFactory.Provider()
        )
    }
    private val deepLink by lazy { deepLinkIntent?.data }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentProfileBinding.inflate(inflater, container, false)
        binding.viewModel = viewModel
        args.queryValue?.let {
            binding.textMonitor.append("\n${it}")
        }
        deepLink?.let {
            binding.textMonitor.append("\n${deepLink}")
        }

        // view-model scope
        viewModel.apply {
            consume(onActionCompleted) { navDirection: NavDirections ->
                navigate(navDirection)
            }
        }
        return binding.root
    }
}