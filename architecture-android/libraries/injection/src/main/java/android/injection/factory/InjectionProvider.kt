package android.injection.factory

import java.util.concurrent.ConcurrentHashMap
import kotlin.reflect.KClass
import kotlin.reflect.full.allSuperclasses

typealias Definition<T> = () -> T
typealias QualifierValue = String

object InjectionProvider {
    val definitionRegistry: MutableMap<String, Definition<Any>> = ConcurrentHashMap()

    @Suppress("UNCHECKED_CAST")
    fun <T : Any> get(
        clazz: KClass<T>,
        qualifier: QualifierValue? = null,
    ): T {
        val declaration = definitionRegistry[key(clazz, qualifier)]
        val instance = declaration?.invoke()
        if (instance == null) {
            var keys = "["
            for (entry in definitionRegistry.keys) {
                keys += "\n   $entry"
            }
            keys += "\n]"
            error(
                "Unable to find declaration of type ${clazz.qualifiedName}" +
                        "\n   Please declare:\n" +
                        "        provides {\n" +
                        "            declare<${clazz.simpleName}> { TheImplementationOf${clazz.simpleName}() }\n" +
                        "        }" +
                        "\n\n" +
                        "Definitions: $keys"
            )
        }
        return instance as T
    }

    inline fun <reified T : Any> declare(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = definition
    }

    inline fun <reified T : Any> declareWithSuperClasses(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = definition
        for (superClass: KClass<*> in T::class.allSuperclasses) {
            if (!superClass.simpleName.equals("Any")) {
                definitionRegistry[key(superClass, qualifier)] = definition
            }
        }
    }

    fun <T : Any> key(kClass: KClass<T>, qualifier: QualifierValue?): String {
        return """${qualifier.orEmpty()}[${kClass.qualifiedName}]"""
    }
}
