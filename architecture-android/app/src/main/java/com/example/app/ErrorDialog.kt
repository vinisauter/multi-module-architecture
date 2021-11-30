package com.example.app

import androidx.fragment.app.DialogFragment
import androidx.navigation.fragment.navArgs
import com.example.app.databinding.FragmentErrorBinding

class ErrorDialog : DialogFragment(R.layout.fragment_error) {
    private val args: ErrorDialogArgs by navArgs()
    private var viewBinding: FragmentErrorBinding? = null

    override fun onStart() {
        super.onStart()
        viewBinding =
            FragmentErrorBinding.bind(requireView()).also { binding: FragmentErrorBinding ->
                binding.message.text = args.errorMessage
                binding.okButton.setOnClickListener { dismiss() }
            }
    }

    override fun onDestroy() {
        viewBinding = null
        super.onDestroy()
    }
}