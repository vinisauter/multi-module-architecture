package com.core.extensions

import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LiveData
import androidx.lifecycle.MediatorLiveData
import androidx.lifecycle.Observer

@file:Suppress("unused")

import android.os.Handler
import android.os.Looper
import androidx.annotation.MainThread

private fun <T> LiveData<T>.reset() {
    try {
        // mData = LiveData.NOT_SET
        LiveData::class.java.getDeclaredField("mData").let {
            it.isAccessible = true
            it.set(this, LiveData.NOT_SET)
        }
        // mVersion = LiveData.START_VERSION
        LiveData::class.java.getDeclaredField("mVersion").let {
            it.isAccessible = true
            it.set(this, LiveData.START_VERSION)
        }
    } catch (t: Throwable) {
        value = null
    }
}

@MainThread
fun <T> LiveData<T>.observeEvent(owner: LifecycleOwner, observer: Observer<T>) {
    observe(owner, Observer { result ->
        if (result != null) {
            observer.onChanged(result)
        }
        reset()
    })
}

@MainThread
fun <T> LiveData<T>.observeEventOnce(owner: LifecycleOwner, observer: Observer<T>) {
    observe(owner, object : Observer<T> {
        override fun onChanged(result: T) {
            if (result != null) {
                removeObserver(this)
                observer.onChanged(result)
            }
            reset()
        }
    })
}

@MainThread
fun <X> LiveData<X>.nonNull(): LiveData<X> {
    val outputLiveData: MediatorLiveData<X> = MediatorLiveData()
    outputLiveData.addSource(this) { currentValue: X? ->
        if (currentValue != null) outputLiveData.value = currentValue
    }
    return outputLiveData
}

@MainThread
fun <X> LiveData<X>.first(): LiveData<X> {
    val single: MediatorLiveData<X> = MediatorLiveData()
    single.addSource(this) {
        single.value = it
        single.removeSource(this)
    }
    return single
}

@MainThread
fun <X> LiveData<X>.firstNonNull(): LiveData<X> {
    val singleNonNull: MediatorLiveData<X> = MediatorLiveData()
    singleNonNull.addSource(this) {
        if (it != null) {
            singleNonNull.value = it
            singleNonNull.removeSource(this)
        }
    }
    return singleNonNull
}

@MainThread
fun <X> LiveData<X>.debounce(duration: Long): LiveData<X?> {
    val mld: MediatorLiveData<X?> = MediatorLiveData()
    val handler = Handler(Looper.getMainLooper())
    val runnable = Runnable { mld.setValue(this.value) }
    mld.addSource(this) {
        handler.removeCallbacks(runnable)
        handler.postDelayed(runnable, duration)
    }
    return mld
}