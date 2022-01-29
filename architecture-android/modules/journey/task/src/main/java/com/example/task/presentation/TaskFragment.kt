package com.example.task.presentation

import android.content.Context
import android.injection.get
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
import com.example.flutter.FlutterExecutor
import com.example.task.databinding.FragmentTaskBinding

class TaskFragment: Fragment() {
    private lateinit var binding: FragmentTaskBinding
    private val args: TaskFragmentArgs by navArgs()
    private val viewModel: TaskFragmentViewModel by injectViewModel()
    private val deepLink by lazy { deepLinkIntent?.data }

    private val flutter: FlutterExecutor by lazy { get() }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentTaskBinding.inflate(inflater, container, false)
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

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val childFragment = flutter.getFragment(requireContext(), "task")

        childFragmentManager
            .beginTransaction()
            .add(binding.childFragmentContainer.id, childFragment)
            .commit()
    }

    override fun onDestroyView() {
        super.onDestroyView()

//        engineCache.get(engineId)?.let {
//            it.destroy()
//            engineCache.remove(engineId)
//        }
    }
}