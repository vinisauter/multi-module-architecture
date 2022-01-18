package com.example.home

import java.lang.ref.WeakReference

interface HomeDataModelObserver {
    fun onCountUpdate(newCount: Int)
}

class HomeDataModel {
    companion object {
        val instance = HomeDataModel()
    }

    private val observers = mutableListOf<WeakReference<HomeDataModelObserver>>()

    var counter = 0
        set(value) {
            field = value
            for (observer in observers) {
                observer.get()?.onCountUpdate(value)
            }
        }

    fun addObserver(observer: HomeDataModelObserver) {
        observers.add(WeakReference(observer))
    }

    fun removeObserver(observer: HomeDataModelObserver) {
        observers.removeIf {
            if (it.get() != null) it.get() == observer else true
        }
    }
}
