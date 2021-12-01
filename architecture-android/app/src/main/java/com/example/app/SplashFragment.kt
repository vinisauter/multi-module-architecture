package com.example.app

import android.os.Bundle
import android.view.View
import androidx.core.net.toUri
import androidx.fragment.app.Fragment
import androidx.navigation.NavDeepLinkRequest
import androidx.navigation.fragment.findNavController
import com.core.extensions.navigate
import com.example.app.databinding.FragmentSplashBinding

class SplashFragment : Fragment(R.layout.fragment_splash) {
    private var viewBinding: FragmentSplashBinding? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding = FragmentSplashBinding.bind(view).also { binding: FragmentSplashBinding ->
            binding.loginButton.setOnClickListener { navigate(SplashFragmentDirections.actionLogin()) }
//            binding.accessionButton.setOnClickListener { navigate(MainFragmentDirections.actionAccession()) }
            binding.deepLinkButton.setOnClickListener {
                val link = binding.deepLinkEditText.text.toString().toUri()
                val request = NavDeepLinkRequest.Builder
                    .fromUri(link)
                    .build()
                findNavController().navigate(request)
            }
        }
    }

    override fun onDestroy() {
        viewBinding = null
        super.onDestroy()
    }
}
