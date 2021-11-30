package com.example.home.presentation

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class HomeViewModel: ViewModel() {

    private val _profileButton: MutableLiveData<Boolean> = MutableLiveData()
    val profileButton: LiveData<Boolean>
        get()= _profileButton

    private val _exitButton: MutableLiveData<Boolean> = MutableLiveData()
    val exitButton: LiveData<Boolean>
        get()= _exitButton

    fun onProfileButtonClicked(){
        _profileButton.postValue(true)
    }

    fun onExitButtonClicked(){
        _exitButton.postValue(true)
    }
}