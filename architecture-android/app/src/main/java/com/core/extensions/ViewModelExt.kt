package com.core.extensions

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope

sealed class State {
    object Idle : State()
    object Running : State()
}

sealed class StateResult {
    object Idle : StateResult()
    object Loading : StateResult()
    data class Success<T>(val value: T) : StateResult()
    data class Error(val error: Throwable) : StateResult()
}

fun ViewModel.runTask(
    state: MutableLiveData<State> = MutableLiveData<State>(State.Idle),
    function: suspend CoroutineScope.() -> Unit
) {
    viewModelScope.onCpu {
        state.postValue(State.Running)
        function.invoke(this)
        state.postValue(State.Idle)
    }
}
