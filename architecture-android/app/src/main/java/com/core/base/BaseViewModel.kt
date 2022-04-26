package com.core.base

import android.app.Application
import androidx.lifecycle.*
import com.core.extensions.State
import com.core.extensions.onCpu
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

abstract class BaseViewModel<ViewEvent : BaseViewEvent, ViewEffect : BaseViewEffect>(
    application: Application,
    savedStateHandle: SavedStateHandle
) : AndroidViewModel(application) {
    private val viewEffectFlow = MutableSharedFlow<ViewEffect>()
    internal val viewEffect: Flow<ViewEffect>
        get() = viewEffectFlow

    // TODO: handle case of multiple states running at same time?
    private val onStateChangedMutable = MutableLiveData<State>(State.Idle)
    internal val onStateChanged: LiveData<State>
        get() = onStateChangedMutable

    abstract fun processEvent(event: ViewEvent)
    protected suspend fun emitEffect(effect: ViewEffect) {
        viewEffectFlow.emit(effect)
    }

    fun runTask(function: suspend CoroutineScope.() -> Unit) = viewModelScope.onCpu {
        onStateChangedMutable.postValue(State.Running)
        var error: Throwable? = null
        try {
            function.invoke(this)
        } catch (throwable: Throwable) {
            error = throwable
        }
        onStateChangedMutable.postValue(State.Idle)
        if (error != null) throw error
    }
}