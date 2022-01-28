package com.example.note.presentation

import android.content.Context
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
import com.example.note.databinding.FragmentNoteBinding

class NoteFragment: Fragment() {
    private lateinit var binding: FragmentNoteBinding
    private val args: NoteFragmentArgs by navArgs()
    private val viewModel: NoteFragmentViewModel by injectViewModel()
    private val deepLink by lazy { deepLinkIntent?.data }

    private lateinit var engineId: String

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentNoteBinding.inflate(inflater, container, false)
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