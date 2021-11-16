package com.auto.service.dynamic.instance

import kotlin.reflect.KClass

interface Provider {
    suspend fun <T : Any> getImpl(kClass: KClass<T>): T
}

suspend inline fun <reified T : Any> Provider.impl(): T {
    return getImpl(T::class)
}