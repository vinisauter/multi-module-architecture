package com.example.core

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

abstract class NextBaseViewModel : ViewModel() {

    val mViewState = MutableLiveData<ViewState>(ViewState.Initial)

    sealed class ViewState() {
        object Success : ViewState()
        object Error : ViewState()
        object Loading : ViewState()
        object Initial : ViewState()
    }

}