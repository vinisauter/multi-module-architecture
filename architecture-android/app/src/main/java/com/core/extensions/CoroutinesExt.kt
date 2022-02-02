package com.core.extensions

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

object DefaultDispatcherProvider {
    var Main: CoroutineDispatcher = Dispatchers.Main
    var Default: CoroutineDispatcher = Dispatchers.Default
    var IO: CoroutineDispatcher = Dispatchers.IO
    var Unconfined: CoroutineDispatcher = Dispatchers.Unconfined
}

/**
 * Usado para usos intensivos de CPU, como ordenação de listas, parse de JSON, DiffUtils, etc;
 */
fun CoroutineScope.onCpu(function: suspend CoroutineScope.() -> Unit) {
    launch(DefaultDispatcherProvider.Default) {
        function()
    }
}

/**
 * Usa a thread de UI (user interface).
 * Portanto, só é recomendado usar quando realmente precisar interagir com a interface de usuário;
 */
fun CoroutineScope.onMain(function: suspend CoroutineScope.() -> Unit) {
    launch(DefaultDispatcherProvider.Main) {
        function()
    }
}

/**
 * Usado para operações de input/output.
 * Geralmente é usado quando precisa esperar uma resposta,
 * como por exemplo: requisições para um servidor, leitura e/ou escrita num banco de dados, etc;
 */
fun CoroutineScope.onIO(function: suspend CoroutineScope.() -> Unit) {
    launch(DefaultDispatcherProvider.IO) {
        function()
    }
}

/**
 * Para operações que não precisam de uma thread específica.
 * É recomendado usar quando não consome tempo de CPU nem atualiza dados compartilhados,
 * é executada na mesma thread de quem a chamou,
 * mas só se mantém nessa thread até o primeiro ponto de suspensão.
 */
fun CoroutineScope.onCurrent(function: suspend CoroutineScope.() -> Unit) {
    launch(DefaultDispatcherProvider.Unconfined) {
        function()
    }
}