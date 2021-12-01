package com.core.extensions

import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.LiveData
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

fun <T> AppCompatActivity.consume(flow: Flow<T>, function: (value: T) -> Unit) {
    lifecycleScope.launch {
        flow.collect {
            function(it)
        }
    }
}

fun <T> AppCompatActivity.consume(liveData: LiveData<T>, function: (value: T) -> Unit) {
    liveData.observe(this) {
        function(it)
    }
}
