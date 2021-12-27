package android.injection

import android.injection.InjectionProvider.key
import android.injection.factory.SharedFactory
import kotlin.reflect.full.allSuperclasses

data class Module(
    val name: String,
    val keys: MutableList<String> = mutableListOf(),
) {
    inline fun <reified T : Any> shared(
        qualifier: QualifierValue? = null,
        definition: Definition<T>,
    ) {
        provider.definitionRegistry[key(T::class, qualifier)] = SharedFactory(definition.invoke())
        keys.add(key(T::class, qualifier))
    }

    inline fun <reified T : Any> sharedWithSuperClasses(
        qualifier: QualifierValue? = null,
        definition: Definition<T>,
    ) {
        shared(qualifier, definition)
        for (superclass in T::class.allSuperclasses) {
            if (!superclass.simpleName.equals("Any")) {
                val currentKey = key(superclass, qualifier)
                provider.definitionRegistry[key(superclass, qualifier)] =
                    SharedFactory(definition.invoke())
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