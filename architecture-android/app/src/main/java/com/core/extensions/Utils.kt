package com.core.extensions

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.widget.Toast

fun <T> T?.default(default: T): T {
    return this ?: default
}

fun Context.longToast(text: CharSequence) {
    Handler(Looper.getMainLooper()).post { Toast.makeText(this, text, Toast.LENGTH_LONG).show() }
}

fun Throwable.errorMessage(): String {
    return localizedMessage ?: message ?: javaClass.name
}

fun Throwable.filterStackTrace(notContains: String): Throwable {
    val filtered = stackTrace.filterNot { it.className.contains(notContains) }
    stackTrace = filtered.toTypedArray()
    cause?.let { cause ->
        val causeFiltered = cause.stackTrace.filterNot { it.className.contains(notContains) }
        cause.stackTrace = causeFiltered.toTypedArray()
    }
    return this
}