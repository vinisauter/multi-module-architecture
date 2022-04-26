package com.example.login.presentation

import android.app.Application
import androidx.lifecycle.SavedStateHandle
import com.core.base.BaseViewModel
import com.core.extensions.default
import com.example.journey.login.tracking.LoginTracking
import com.example.tagging.TaggingExecutor

class LoginFragmentViewModel(
    private val app: Application,
    private val savedStateHandle: SavedStateHandle,
    private val tagging: TaggingExecutor,
    private val useCase: LoginFragmentUseCases,
    private val tracking: LoginTracking
) : BaseViewModel<LoginFragmentEvent, LoginFragmentEffect>(app, savedStateHandle) {

    // processEvent -> run action -> emitEffect:
    // todo tagueamento pode ser feito aqui pois tem todas as iterações com tela mapeadas
    //  Event = evento de interação com a tela
    //  Effect = efeito que alguma ação causa a tela .
    override fun processEvent(event: LoginFragmentEvent) = runTask {
        when (event) {// TODO: cada evento pode virar um metodo PRIVADO
            LoginFragmentEvent.OnScreenLoad -> tagging.send(tracking.loginScreenName)
            LoginFragmentEvent.OnBackPressed -> emitEffect(LoginFragmentEffect.Exit)
            LoginFragmentEvent.OnLogin -> {
                tagging.send(tracking.loginClickAuthEvent)
                try {
                    when (useCase.login("user", "password")) {
                        true -> {
                            emitEffect(LoginFragmentEffect.Direction(LoginFragmentDirections.actionLoginSucceed()))
                            tagging.send(tracking.loginAuthSucceededEvent)
                        }
                        false -> {
                            emitEffect(LoginFragmentEffect.Direction(LoginFragmentDirections.actionLoginFailed()))
                            tagging.send(tracking.loginAuthFailedEvent)
                        }
                    }
                } catch (t: Throwable) {
                    emitEffect(LoginFragmentEffect.Direction(LoginFragmentDirections.actionLoginFailed()))
                    tagging.send(tracking.loginAuthFailedEvent)
                }
            }
            LoginFragmentEvent.OnForgotPassword -> {
                tagging.send(tracking.loginClickForgotPasswordEvent)
                try {
                    emitEffect(LoginFragmentEffect.Direction(LoginFragmentDirections.actionForgotPassword()))
                    tagging.send(tracking.loginForgotPasswordSucceededEvent)
                } catch (t: Throwable) {
                    emitEffect(
                        LoginFragmentEffect.Direction(
                            LoginFragmentDirections.actionShowError(
                                t.message.default("ERROR")
                            )
                        )
                    )
                    tagging.send(tracking.loginForgotPasswordFailedEvent)
                }

            }
        }
    }
}