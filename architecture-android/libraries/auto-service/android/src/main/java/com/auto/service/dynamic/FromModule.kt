package com.auto.service.dynamic

@MustBeDocumented
@kotlin.annotation.Retention(AnnotationRetention.RUNTIME)
@Target(AnnotationTarget.ANNOTATION_CLASS, AnnotationTarget.CLASS)
annotation class FromModule(
    /**
     * Returns the Module Name where can be found the implemented service.
     */
    val value: String
)