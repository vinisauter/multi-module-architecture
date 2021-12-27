package com.core.extensions

import androidx.fragment.app.Fragment
import androidx.lifecycle.LiveData
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

fun <T> Fragment.consume(flow: Flow<T>, function: (value: T) -> Unit) {
    viewLifecycleOwner.lifecycleScope.launch {
        flow.collect {
            function(it)
        }
    }
}

fun <T> Fragment.consume(liveData: LiveData<T>, function: (value: T) -> Unit) {
    liveData.observe(viewLifecycleOwner) {
        function(it)
    }
}