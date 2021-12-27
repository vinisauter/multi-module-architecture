package com.core.extensions

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope

enum class State {
    Idle,
    Running
}

sealed class StateResult {
    object Initial : StateResult()
    object Loading : StateResult()
    data class Success<T>(val value: T) : StateResult()
    data class Error(val error: Throwable) : StateResult()
}

fun ViewModel.runTask(
    state: MutableLiveData<State> = MutableLiveData<State>(State.Idle),
    function: suspend CoroutineScope.() -> Unit
): LiveData<State> {
    viewModelScope.onCpu {
        state.postValue(State.Running)
        var error: Throwable? = null
        try {
            function.invoke(this)
        } catch (throwable: Throwable) {
            error = throwable
        }
        state.postValue(State.Idle)
        if (error != null) throw error
    }
    return state
}

fun <T> ViewModel.runTaskResult(
    state: MutableLiveData<StateResult> = MutableLiveData<StateResult>(StateResult.Initial),
    function: suspend CoroutineScope.() -> T
): LiveData<StateResult> {
    viewModelScope.onCpu {
        state.postValue(StateResult.Loading)
        try {
            val value: T = function.invoke(this)
            state.postValue(StateResult.Success(value))
        } catch (error: Throwable) {
            state.postValue(StateResult.Error(error))
        }
    }
    return state
}