package com.auto.service

import java.util.*

@Throws(NoSuchElementException::class)
inline fun <reified T : Any> load(): T = try {
    val serviceLoader: ServiceLoader<T> =
        ServiceLoader.load(T::class.java, T::class.java.classLoader)
    serviceLoader.iterator().next()
} catch (t: Throwable) {
    throw
    IllegalStateException(
        "ServiceLoader ${T::class.java.name} " +
                "class implementation not found or class does not have empty constructor", t
    )
}

inline fun <reified T : Any> lazyLoad(
    mode: LazyThreadSafetyMode = LazyThreadSafetyMode.SYNCHRONIZED,
) = lazy(mode) { load<T>() }