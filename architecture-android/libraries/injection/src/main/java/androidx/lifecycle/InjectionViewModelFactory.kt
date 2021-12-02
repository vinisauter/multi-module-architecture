package androidx.lifecycle

import android.annotation.SuppressLint
import android.app.Application
import android.injection.InjectionProvider
import android.injection.QualifierValue
import android.injection.annotation.Qualifier
import android.os.Bundle
import androidx.savedstate.SavedStateRegistry
import androidx.savedstate.SavedStateRegistryOwner
import java.lang.reflect.InvocationTargetException
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
class InjectionViewModelFactory @SuppressLint("LambdaLast") constructor(
    private val application: Application? = null,
    private val savedStateRegistryOwner: SavedStateRegistryOwner,
    private val defaultArgs: Bundle? = null,
) : ViewModelProvider.Factory {
    private val lifecycle: Lifecycle = savedStateRegistryOwner.lifecycle
    private val savedStateRegistry: SavedStateRegistry = savedStateRegistryOwner.savedStateRegistry

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return try {
            newInstanceOf(modelClass) as T
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

    private fun newInstanceOf(clazz: Class<*>): Any {
        val kClass = clazz.kotlin
        var controller: SavedStateHandleController? = null
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
                    val canonicalName = clazz.canonicalName
                    controller = SavedStateHandleController.create(
                        savedStateRegistry, lifecycle, canonicalName, defaultArgs
                    )
                    args[parameterType] = controller?.handle
                }
                else -> {
                    var qualifier: QualifierValue? = null
                    for (annotation in parameterType.annotations) {
                        if (annotation is Qualifier) {
                            qualifier = (parameterType.annotations[0] as Qualifier).value
                            break
                        }
                    }
                    val value = InjectionProvider.getDefinition(
                        parameterType.type.classifier as KClass<*>,
                        qualifier
                    )
                    args[parameterType] = value
                }
            }
        }
        val instance = kFunction.callBy(args)
        if (controller != null) {
            (instance as ViewModel).setTagIfAbsent(
                AbstractSavedStateViewModelFactory.TAG_SAVED_STATE_HANDLE_CONTROLLER,
                controller
            )
        }
        return instance
    }
}