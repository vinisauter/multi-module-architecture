package com.example.home.viewmodel

import androidx.lifecycle.ViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class HomeViewModel: ViewModel() {

    private val _btProfile = MutableStateFlow(false)
    val btProfile: StateFlow<Boolean> = _btProfile

    private val _btAgreement = MutableStateFlow(false)
    val btAgreement: StateFlow<Boolean> = _btAgreement

    private val _btLogout = MutableStateFlow(false)
    val btLogout: StateFlow<Boolean> = _btLogout

    fun onBtProfileClick(){
        _btProfile.value = true
    }

    fun onBtAgreementClick(){
        _btAgreement.value = true
    }

    fun onBtLogoutClick(){
        _btLogout.value = true
    }
}