package android.injection

import android.injection.factory.*
import android.injection.factory.InjectionProvider.key
import java.util.concurrent.ConcurrentHashMap
import kotlin.reflect.KClass
import kotlin.reflect.full.allSuperclasses

data class Module(
    val name: String,
    val keys: MutableList<String> = mutableListOf(),
){

    inline fun <reified T : Any> shared(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        provider.shared(qualifier, definition)
        keys.add(key(T::class, qualifier))
    }

    inline fun <reified T : Any> declare(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        provider.declare(qualifier, definition)
        keys.add(key(T::class, qualifier))
    }

    inline fun <reified T : Any> declareWithSuperClasses(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        declare(qualifier, definition)
        for (superclass in T::class.allSuperclasses) {
            if (!superclass.simpleName.equals("Any")) {
                val currentKey = key(superclass, qualifier)
                provider.definitionRegistry[currentKey] = DefinitionFactory(definition)
                keys.add(currentKey)
            }
        }
    }

    inline fun <reified T : Any> sharedWithSuperClasses(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        shared(qualifier, definition)
        for (superclass in T::class.allSuperclasses) {
            if (!superclass.simpleName.equals("Any")) {
                val currentKey = key(superclass, qualifier)
                provider.definitionRegistry[key(superclass, qualifier)] = SharedFactory(definition)
                keys.add(currentKey)
            }
        }
    }

    fun clear() {
        for (key in keys) {
            provider.definitionRegistry.remove(key)
        }
        provider.moduleRegistry.remove(name)
    }
}