package com.example.note.presentation

import android.injection.get
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.injectViewModel
import androidx.navigation.NavDirections
import androidx.navigation.fragment.navArgs
import com.core.extensions.consume
import com.core.extensions.deepLinkIntent
import com.core.extensions.navigate
import com.example.flutter.BaseFlutterFragment
import com.example.flutter.FlutterExecutor
import com.example.note.databinding.FragmentNoteBinding

class NoteFragment: BaseFlutterFragment("note") {
    private lateinit var binding: FragmentNoteBinding
    private val args: NoteFragmentArgs by navArgs()
    private val viewModel: NoteFragmentViewModel by injectViewModel()
    private val deepLink by lazy { deepLinkIntent?.data }

    override val flutter: FlutterExecutor
        get() = get()

    override val fragmentContainerId: Int
        get() = binding.childFragmentContainer.id

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
            handleDeepLink(it)
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