package com.core.extensions

import java.lang.reflect.ParameterizedType

fun <Type> Any.getClassTypeAt(position: Int): Class<Type> {
    @Suppress("UNCHECKED_CAST")
    return (this::class.java.genericSuperclass as ParameterizedType).actualTypeArguments[position] as Class<Type>
}