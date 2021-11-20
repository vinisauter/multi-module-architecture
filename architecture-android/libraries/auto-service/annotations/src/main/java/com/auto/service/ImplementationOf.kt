package com.auto.service

import kotlin.reflect.KClass

@MustBeDocumented
@Retention(AnnotationRetention.BINARY)
@Target(AnnotationTarget.CLASS)
annotation class ImplementationOf(
    /**
     * Returns the interfaces implemented by this service provider.
     */
    val value: KClass<*>,
)