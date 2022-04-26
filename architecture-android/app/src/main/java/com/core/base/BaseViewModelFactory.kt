package com.core.base

import android.app.Application
import android.os.Bundle
import androidx.lifecycle.AbstractSavedStateViewModelFactory
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.savedstate.SavedStateRegistryOwner
import java.lang.reflect.InvocationTargetException
import java.util.concurrent.ConcurrentHashMap
import kotlin.collections.set
import kotlin.reflect.KClass
import kotlin.reflect.KParameter
import kotlin.reflect.full.createType
import kotlin.reflect.full.isSupertypeOf
import kotlin.reflect.full.primaryConstructor
import kotlin.reflect.jvm.isAccessible

/**
 * [androidx.lifecycle.ViewModelProvider.Factory] that can create ViewModels accessing and
 * contributing to a saved state via [SavedStateHandle] received in a constructor.
 * If `defaultArgs` bundle was passed into the constructor, it will provide default
 * values in `SavedStateHandle`.
 *
 *
 * If ViewModel is instance of [androidx.lifecycle.AndroidViewModel], it looks for a
 * constructor that receives an [Application] and [SavedStateHandle] (in this order),
 * otherwise it looks for a constructor that receives [SavedStateHandle] only.
 * [androidx.lifecycle.AndroidViewModel] is only supported if you pass a non-null
 * [Application] instance.
 */
@Suppress("UNCHECKED_CAST")
class BaseViewModelFactory constructor(
    private val application: Application,
    savedStateRegistryOwner: SavedStateRegistryOwner,
    defaultArgs: Bundle? = null,
    private val provider: Provider = Provider()
) : AbstractSavedStateViewModelFactory(savedStateRegistryOwner, defaultArgs) {

    override fun <T : ViewModel> create(
        key: String,
        modelClass: Class<T>,
        handle: SavedStateHandle
    ): T {
        return try {
            newInstanceOf(modelClass, handle) as T
        } catch (e: IllegalAccessException) {
            throw RuntimeException("Failed to access $modelClass", e)
                .filterStackTrace("android")
        } catch (e: InstantiationException) {
            throw RuntimeException("A $modelClass cannot be instantiated.", e)
                .filterStackTrace("android")
        } catch (e: InvocationTargetException) {
            throw RuntimeException("An exception happened in constructor of $modelClass", e.cause)
                .filterStackTrace("android")
        } catch (e: Exception) {
            throw RuntimeException("Cannot create an instance of $modelClass", e)
                .filterStackTrace("android")
        }
    }

    private fun Throwable.filterStackTrace(notContains: String): Throwable {
        val filtered = stackTrace.filterNot { it.className.contains(notContains) }
        stackTrace = filtered.toTypedArray()
        cause?.let { cause ->
            val causeFiltered = cause.stackTrace.filterNot { it.className.contains(notContains) }
            cause.stackTrace = causeFiltered.toTypedArray()
        }
        return this
    }

    private fun newInstanceOf(clazz: Class<*>, handle: SavedStateHandle): Any {
        val kClass = clazz.kotlin
        val kFunction = kClass.primaryConstructor ?: kClass.constructors.first()
        try {
            kFunction.isAccessible = true
        } catch (ignored: SecurityException) {
        }
        val args: HashMap<KParameter, Any?> = HashMap()
        val parameterTypes: List<KParameter> = kFunction.parameters
        for (parameterType: KParameter in parameterTypes) {
            when {
                parameterType.type.isSupertypeOf(Application::class.createType()) -> {
                    args[parameterType] = application
                }
                parameterType.type.isSupertypeOf(SavedStateHandle::class.createType()) -> {
                    args[parameterType] = handle
                }
                else -> {
                    var qualifier: String? = null
                    for (annotation in parameterType.annotations) {
                        if (annotation is Qualifier) {
                            qualifier = (parameterType.annotations[0] as Qualifier).value
                            break
                        }
                    }
                    val value = provider.getDefinition(
                        parameterType.type.classifier as KClass<*>,
                        qualifier
                    )
                    args[parameterType] = value
                }
            }
        }
        return kFunction.callBy(args)
    }

    @MustBeDocumented
    @kotlin.annotation.Retention(AnnotationRetention.RUNTIME)
    @Target(AnnotationTarget.VALUE_PARAMETER)
    annotation class Qualifier(
        val value: String
    )

    open class Provider(block: Provider.() -> Unit = {}) {
        val definitionRegistry: MutableMap<String, () -> Any> = ConcurrentHashMap()

        init {
            this.apply(block)
        }

        fun <T : Any> key(kClass: KClass<T>, qualifier: String?): String {
            return """(${kClass.qualifiedName}${qualifier?.let { " - $qualifier" } ?: ""})"""
        }

        inline fun <reified T : Any> declare(
            qualifier: String? = null,
            noinline definition: () -> T,
        ) {
            definitionRegistry[key(T::class, qualifier)] = definition
        }

        fun <T : Any> getDefinition(clazz: KClass<T>, qualifier: String? = null): T {
            val declaration = definitionRegistry[key(clazz, qualifier)]
            val instance = declaration?.invoke()
            instance ?: run {
                var keys = "["
                for (entry in definitionRegistry.keys.sorted()) {
                    keys += "\n   $entry"
                }
                keys += "\n]"
                val error = IllegalStateException(
                    "Unable to find declaration of type ${clazz.qualifiedName} " +
                            (qualifier?.let { "with qualifier: \"$qualifier\"" } ?: "") +
                            "\n   Please declare:\n" +
                            "        provides {\n" +
                            "            declare<${clazz.simpleName}>${qualifier?.let { "(qualifier = \"$qualifier\")" } ?: ""} { TheImplementationOf${clazz.simpleName}() }\n" +
                            "        }" +
                            "\n\n" +
                            "Definitions: $keys"
                )
                throw error
            }
            return instance as T
        }
    }
}
