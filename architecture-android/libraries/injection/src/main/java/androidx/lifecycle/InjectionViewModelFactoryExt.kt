package androidx.lifecycle

import android.app.Application
import android.content.ContextWrapper
import androidx.activity.ComponentActivity
import androidx.annotation.MainThread
import androidx.fragment.app.Fragment

/**
 * Returns a [Lazy] delegate to access the ComponentActivity's ViewModel, if [factoryProducer]
 * is specified then [ViewModelProvider.Factory] returned by it will be used
 * to create [ViewModel] first time.
 *
 * ```
 * class MyComponentActivity : ComponentActivity() {
 *     val viewmodel: MyViewModel by viewmodels()
 * }
 * ```
 *
 * This property can be accessed only after the Activity is attached to the Application,
 * and access prior to that will result in IllegalArgumentException.
 */
@MainThread
public inline fun <reified VM : ViewModel> ComponentActivity.injectViewModel(
    noinline factoryProducer: (() -> ViewModelProvider.Factory)? = null,
): Lazy<VM> {
    val factoryPromise = factoryProducer ?: {
        InjectionViewModelFactory(
            application,
            this,
            intent?.extras
        )
    }

    return ViewModelLazy(VM::class, { viewModelStore }, factoryPromise)
}

/**
 * Returns a [Lazy] delegate to access the ComponentActivity's ViewModel, if [factoryProducer]
 * is specified then [ViewModelProvider.Factory] returned by it will be used
 * to create [ViewModel] first time.
 *
 * ```
 * class MyComponentActivity : ComponentActivity() {
 *     val viewmodel: MyViewModel by viewmodels()
 * }
 * ```
 *
 * This property can be accessed only after the Activity is attached to the Application,
 * and access prior to that will result in IllegalArgumentException.
 */
@MainThread
public inline fun <reified VM : ViewModel> Fragment.injectViewModel(
    noinline factoryProducer: (() -> ViewModelProvider.Factory)? = null,
): Lazy<VM> {
    val factoryPromise = factoryProducer ?: {
        var application: Application? = null
        var appContext = requireContext().applicationContext
        while (appContext is ContextWrapper) {
            if (appContext is Application) {
                application = appContext
                break
            }
            appContext = appContext.baseContext
        }
        if (application == null) {
            throw error("Could not find Application instance from "
                    + "Context " + requireContext().applicationContext + ", you will "
                    + "not be able to use AndroidViewModel with the default "
                    + "ViewModelProvider.Factory")
        }
        InjectionViewModelFactory(
            application,
            this,
            arguments
        )
    }

    return ViewModelLazy(VM::class, { viewModelStore }, factoryPromise)
}

/**
 * Returns a property delegate to access parent activity's [ViewModel],
 * if [factoryProducer] is specified then [ViewModelProvider.Factory]
 * returned by it will be used to create [ViewModel] first time. Otherwise, the activity's
 * [androidx.activity.ComponentActivity.getDefaultViewModelProviderFactory](default factory)
 * will be used.
 *
 * ```
 * class MyFragment : Fragment() {
 *     val viewmodel: MyViewModel by activityViewModels()
 * }
 * ```
 *
 * This property can be accessed only after this Fragment is attached i.e., after
 * [Fragment.onAttach()], and access prior to that will result in IllegalArgumentException.
 */
@MainThread
public inline fun <reified VM : ViewModel> Fragment.injectActivityViewModel(
    noinline factoryProducer: (() -> ViewModelProvider.Factory)? = null,
): Lazy<VM> {
    var application: Application? = null
    var appContext = requireContext().applicationContext
    while (appContext is ContextWrapper) {
        if (appContext is Application) {
            application = appContext
            break
        }
        appContext = appContext.baseContext
    }
    if (application == null) {
        throw error("Could not find Application instance from "
                + "Context " + requireContext().applicationContext + ", you will "
                + "not be able to use AndroidViewModel with the default "
                + "ViewModelProvider.Factory")
    }
    val factoryPromise = factoryProducer ?: {
        InjectionViewModelFactory(
            application,
            this,
            arguments
        )
    }

    return ViewModelLazy(VM::class, { requireActivity().viewModelStore }, factoryPromise)
}