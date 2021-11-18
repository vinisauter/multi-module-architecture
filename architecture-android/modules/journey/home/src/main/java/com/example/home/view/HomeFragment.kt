package com.example.home.view

import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.FragmentExtensions.consume
import androidx.fragment.app.FragmentExtensions.deeplink
import androidx.fragment.app.viewModels
import com.example.app.base.BaseLauncher
import com.example.app.base.LauncherFragment
import com.example.home.HomeLauncher
import com.example.app.R
import com.example.home.databinding.FragmentHomeBinding
import com.example.home.viewmodel.HomeViewModel


class HomeFragment : LauncherFragment() {
    override val launcher: BaseLauncher = HomeLauncher
    private val viewModel: HomeViewModel by viewModels()
    private lateinit var binding: FragmentHomeBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater, container, false)
        binding.viewModel = viewModel
        return binding.root

    }

    override fun onStart() {
        super.onStart()
        consume(viewModel.btProfile) { success ->
            if (success) {
                Log.w("PRESSED", "profileButton")
            }
        }
        consume(viewModel.btAgreement) { success ->
            if (success) {
                Log.w("PRESSED", "agreementButton")
            }
        }
        consume(viewModel.btLogout) { success ->
            if (success) {
                val link = Uri.parse(getString(R.string.logout_deeplink))
                deeplink(link)
            }
        }
    }

    override fun execute() {}

}