package android.injection.factory

import android.injection.Module
import java.util.concurrent.ConcurrentHashMap
import kotlin.reflect.KClass
import kotlin.reflect.full.allSuperclasses

typealias Definition<T> = () -> T
typealias QualifierValue = String

object InjectionProvider {
    val definitionRegistry: MutableMap<String, InjectionFactory<Any>> = ConcurrentHashMap()
    val moduleRegistry: MutableMap<String, Module> = ConcurrentHashMap()

    inline fun module(name: String, block: Module.() -> Unit) = Module(name).apply{
        moduleRegistry[name]?.let{
            error("module $name already exists")
        }
        block.invoke(this)
        moduleRegistry[name] = this
    }

    @Suppress("UNCHECKED_CAST")
    fun <T : Any> getDefinition(
        clazz: KClass<T>,
        qualifier: QualifierValue? = null,
    ): T {
        val declaration = definitionRegistry[key(clazz, qualifier)]
        val instance = declaration?.get()
        instance?:run{
            var keys = "["
            for (entry in definitionRegistry.keys) {
                keys += "\n   $entry"
            }
            keys += "\n]"
            error(
                "Unable to find declaration of type ${clazz.qualifiedName}" +
                        "\n   Please declare:\n" +
                        "        provides {\n" +
                        "            module(\"moduleName\"){\n"+
                        "                declare<${clazz.simpleName}> { TheImplementationOf${clazz.simpleName}() }\n" +
                        "            }\n" +
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
        definitionRegistry[key(T::class, qualifier)] = DefinitionFactory(definition)
    }

    inline fun <reified T : Any> shared(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = SharedFactory(definition)
    }

    inline fun <reified T : Any> declareWithSuperClasses(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = DefinitionFactory(definition)
        for (superClass: KClass<*> in T::class.allSuperclasses) {
            if (!superClass.simpleName.equals("Any")) {
                definitionRegistry[key(superClass, qualifier)] = DefinitionFactory(definition)
            }
        }
    }

    inline fun <reified T : Any> sharedWithSuperClasses(
        qualifier: QualifierValue? = null,
        noinline definition: Definition<T>,
    ) {
        definitionRegistry[key(T::class, qualifier)] = SharedFactory(definition)
        for (superClass: KClass<*> in T::class.allSuperclasses) {
            if (!superClass.simpleName.equals("Any")) {
                definitionRegistry[key(superClass, qualifier)] = SharedFactory(definition)
            }
        }
    }

    fun <T : Any> key(kClass: KClass<T>, qualifier: QualifierValue?): String {
        return """${qualifier.orEmpty()}[${kClass.qualifiedName}]"""
    }

}
