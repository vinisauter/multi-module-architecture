package com.example.app

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import com.core.extensions.navigate
import com.example.app.databinding.FragmentSplashBinding

class SplashFragment : Fragment(R.layout.fragment_splash) {
    private var viewBinding: FragmentSplashBinding? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding = FragmentSplashBinding.bind(view).also { binding: FragmentSplashBinding ->
            binding.loginButton.setOnClickListener { navigate(SplashFragmentDirections.actionLogin()) }
//            binding.accessionButton.setOnClickListener { navigate(MainFragmentDirections.actionAccession()) }
//            binding.deepLinkButton.setOnClickListener { val link = binding.deepLinkEditText.text.toString().toUri() }
        }
    }

    override fun onDestroy() {
        viewBinding = null
        super.onDestroy()
    }
}
