package com.example.profile.presentation

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.Tagging

class ProfileViewModel : ViewModel() {

    private val _homeButton: MutableLiveData<Boolean> = MutableLiveData()
    val homeButton: LiveData<Boolean>
        get()= _homeButton

    private val _expireButton: MutableLiveData<Boolean> = MutableLiveData()
    val expireButton: LiveData<Boolean>
        get()= _expireButton

    private val _loginButton: MutableLiveData<LoginTracking> = MutableLiveData()
    val loginButton: LiveData<LoginTracking>
        get()= _loginButton

    private val _exitButton: MutableLiveData<Boolean> = MutableLiveData()
    val exitButton: LiveData<Boolean>
        get()= _exitButton

    fun onHomeButtonClicked(){
        _homeButton.postValue(true)
    }

    fun onExpireButtonClicked(){
        _expireButton.postValue(true)
    }

    fun onLoginButtonClicked(){
        // TODO extract to file
        val tracking = LoginTracking(
            //LoginFragment
            loginScreenName = Tagging.ScreenName("profile_login"),
            loginClickAuthEvent = Tagging.Event("profile_login", "click", "auth"),
            loginAuthSucceededEvent = Tagging.Event("profile_login", "auth", "succeeded"),
            loginAuthFailedEvent = Tagging.Event("profile_login", "auth", "failed"),
            loginClickForgotPasswordEvent = Tagging.Event(
                "profile_login",
                "click",
                "forgot_password"
            ),
            //ForgotPasswordFragment
            forgotPasswordScreenName = Tagging.ScreenName("profile_forgot_password"),
            forgotPasswordClickExitEvent = Tagging.Event(
                "profile_forgot_password",
                "click",
                "exit"
            ),
        )
        _loginButton.postValue(tracking)
    }

    fun onExitButtonClicked(){
        _exitButton.postValue(true)
    }
}