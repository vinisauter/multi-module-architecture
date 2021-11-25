package android.injection

import android.injection.factory.Definition
import android.injection.factory.InjectionProvider
import android.injection.factory.QualifierValue
import java.util.concurrent.ConcurrentHashMap

data class Module(
    val definitions: MutableMap<String, Definition<Any>> = ConcurrentHashMap(),
    val instances: MutableMap<String, Any> = ConcurrentHashMap()
){

    inline fun <reified T : Any> shared(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitions[InjectionProvider.key(
            T::class,
            qualifier
        )] = definition
    }

    inline fun <reified T : Any> declare(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        provider.declare(qualifier, definition)
    }
}