package com.core.extensions

fun <T> T?.default(default: T): T {
    return this ?: default
}