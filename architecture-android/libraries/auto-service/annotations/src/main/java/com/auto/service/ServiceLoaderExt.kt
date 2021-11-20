package com.auto.service

import java.util.*

@Throws(NoSuchElementException::class)
inline fun <reified T : Any> load(): T {
    val serviceLoader: ServiceLoader<T> =
        ServiceLoader.load(T::class.java, T::class.java.classLoader)
    return serviceLoader.iterator().next()
}

inline fun <reified T : Any> lazyLoad(
    mode: LazyThreadSafetyMode = LazyThreadSafetyMode.SYNCHRONIZED,
) = lazy(mode) { load<T>() }