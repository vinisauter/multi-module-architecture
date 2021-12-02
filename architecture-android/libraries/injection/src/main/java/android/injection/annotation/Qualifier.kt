package android.injection.annotation

import android.injection.QualifierValue

@MustBeDocumented
@kotlin.annotation.Retention(AnnotationRetention.RUNTIME)
@Target(AnnotationTarget.VALUE_PARAMETER)
annotation class Qualifier(
    val value: QualifierValue
)