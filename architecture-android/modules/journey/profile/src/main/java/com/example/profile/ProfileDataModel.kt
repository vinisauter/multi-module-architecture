package com.example.profile

import java.lang.ref.WeakReference

interface ProfileDataModelObserver {
    fun onCountUpdate(newCount: Int)
}

class ProfileDataModel {
    companion object {
        val instance = ProfileDataModel()
    }

    private val observers = mutableListOf<WeakReference<ProfileDataModelObserver>>()

    var counter = 0
        set(value) {
            field = value
            for (observer in observers) {
                observer.get()?.onCountUpdate(value)
            }
        }

    fun addObserver(observer: ProfileDataModelObserver) {
        observers.add(WeakReference(observer))
    }

    fun removeObserver(observer: ProfileDataModelObserver) {
        observers.removeIf {
            if (it.get() != null) it.get() == observer else true
        }
    }
}
