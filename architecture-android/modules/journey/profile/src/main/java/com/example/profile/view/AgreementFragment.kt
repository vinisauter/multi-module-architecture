package com.example.profile.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import com.example.app.base.BaseLauncher
import com.example.app.base.LauncherFragment
import com.example.profile.ProfileLauncher
import com.example.profile.databinding.FragmentAgreementBinding
import com.example.profile.viewmodel.AgreementViewModel

class AgreementFragment : LauncherFragment() {
    override val launcher: BaseLauncher = ProfileLauncher
    private val viewModel: AgreementViewModel by viewModels()
    private lateinit var binding: FragmentAgreementBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentAgreementBinding.inflate(inflater, container, false)
        binding.viewModel = viewModel
        return binding.root

    }

    override fun execute() {}

}