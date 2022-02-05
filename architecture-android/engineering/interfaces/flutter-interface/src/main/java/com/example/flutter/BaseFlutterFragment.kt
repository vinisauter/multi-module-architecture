package com.example.flutter

import android.net.Uri
import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import java.util.*

abstract class BaseFlutterFragment(private val engineIdPrefix: String): Fragment() {
    abstract val flutter: FlutterExecutor
    abstract val fragmentContainerId: Int

    private val engineId: String by lazy {
//        "${engineIdPrefix}_${Calendar.getInstance().timeInMillis}"
        engineIdPrefix
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val childFragment = flutter.getFragment(requireContext(), engineId)

        childFragmentManager
            .beginTransaction()
            .add(fragmentContainerId, childFragment)
            .commit()
    }

    override fun onDetach() {
        super.onDetach()
        flutter.destroyEngine(engineId)
    }

    override fun onDestroyView() {
        super.onDestroyView()
        flutter.destroyEngine(engineId)
    }

    fun handleDeepLink(deepLink: Uri) {
        flutter.handleDeeplink(deepLink, engineId)
    }
}