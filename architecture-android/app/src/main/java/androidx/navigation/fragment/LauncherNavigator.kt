package androidx.navigation.fragment

import android.content.Context
import android.content.ContextParams
import android.util.AttributeSet
import android.util.Log
import androidx.annotation.CallSuper
import androidx.core.content.res.use
import androidx.fragment.app.Launcher
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.navigation.FloatingWindow
import androidx.navigation.NavBackStackEntry
import androidx.navigation.NavDestination
import androidx.navigation.NavOptions
import androidx.navigation.Navigator
import androidx.navigation.NavigatorProvider
import androidx.navigation.NavigatorState
import androidx.navigation.fragment.LauncherNavigator.Destination
import java.lang.RuntimeException


/**
 * Navigator that uses [Launcher.show]. Every
 * destination using this Navigator must set a valid Launcher class name with
 * `android:name` or [Destination.setClassName].
 */
@Navigator.Name("launcher")
public class LauncherNavigator(
    private val context: Context,
    private val fragmentManager: FragmentManager
) : Navigator<Destination>() {
    private var params: Launcher.LauncherParams? = null
    private val restoredTagsAwaitingAttach = mutableSetOf<String>()
    private val observer = LifecycleEventObserver { source, event ->
        if (event == Lifecycle.Event.ON_CREATE) {
            val launcher = source as Launcher
            this.params = Launcher.LauncherParams()
            launcher.params = this.params
            val launcherOnBackStack = state.backStack.value.any { it.id == launcher.tag }
            if (!launcherOnBackStack) {
                // If the Fragment is no longer on the back stack, it must have been
                // been popped before it was actually attached to the FragmentManager
                // (i.e., popped in the same frame as the navigate() call that added it). For
                // that case, we need to dismiss the dialog to ensure the states stay in sync
                launcher.dismiss()
            }
        } else if (event == Lifecycle.Event.ON_STOP) {
            val launcher = source as Launcher
            if (!launcher.requireDialog().isShowing) {
                val beforePopList = state.backStack.value
                val poppedEntry = checkNotNull(beforePopList.lastOrNull {
                    it.id == launcher.tag
                }) {
                    "Launcher $launcher has already been popped off of the Navigation " +
                            "back stack"
                }
                if (beforePopList.lastOrNull() != poppedEntry) {
                    Log.i(
                        TAG, "Launcher $launcher was dismissed while it was not the top " +
                                "of the back stack, popping all dialogs above this dismissed dialog"
                    )
                }
                popBackStack(poppedEntry, false)
            }
        }
    }

    override fun popBackStack(popUpTo: NavBackStackEntry, savedState: Boolean) {
        if (fragmentManager.isStateSaved) {
            Log.i(
                TAG, "Ignoring popBackStack() call: FragmentManager has already saved its state"
            )
            return
        }
        val beforePopList = state.backStack.value
        // Get the set of entries that are going to be popped
        val poppedList = beforePopList.subList(
            beforePopList.indexOf(popUpTo),
            beforePopList.size
        )
        // Now go through the list in reversed order (i.e., starting from the most recently added)
        // and dismiss each dialog
        for (entry in poppedList.reversed()) {
            val existingFragment = fragmentManager.findFragmentByTag(entry.id)
            if (existingFragment != null) {
                existingFragment.lifecycle.removeObserver(observer)
                (existingFragment as Launcher).dismiss()
            }
        }
        state.pop(popUpTo, savedState)
    }

    public override fun createDestination(): Destination {
        return Destination(params, this)
    }

    override fun navigate(
        entries: List<NavBackStackEntry>,
        navOptions: NavOptions?,
        navigatorExtras: Extras?
    ) {
        if (fragmentManager.isStateSaved) {
            Log.i(TAG, "Ignoring navigate() call: FragmentManager has already saved its state")
            return
        }
        for (entry in entries) {
            navigate(entry)
        }
    }

    private fun navigate(
        entry: NavBackStackEntry
    ) {
        val destination = entry.destination as Destination
        var className = destination.className
        if (className[0] == '.') {
            className = context.packageName + className
        }
        val frag = fragmentManager.fragmentFactory.instantiate(
            context.classLoader, className
        )
        require(Launcher::class.java.isAssignableFrom(frag.javaClass)) {
            "Launcher destination ${destination.className} is not an instance of Launcher"
        }
        val launcher = frag as Launcher
        launcher.arguments = entry.arguments
        launcher.lifecycle.addObserver(observer)
        launcher.show(fragmentManager, entry.id)
        state.push(entry)
    }

    override fun onAttach(state: NavigatorState) {
        super.onAttach(state)
        for (entry in state.backStack.value) {
            val fragment = fragmentManager
                .findFragmentByTag(entry.id) as Launcher?
            fragment?.lifecycle?.addObserver(observer)
                ?: restoredTagsAwaitingAttach.add(entry.id)
        }
        fragmentManager.addFragmentOnAttachListener { _, childFragment ->
            val needToAddObserver = restoredTagsAwaitingAttach.remove(childFragment.tag)
            if (needToAddObserver) {
                childFragment.lifecycle.addObserver(observer)
            }
        }
    }

    /**
     * NavDestination specific to [LauncherNavigator].
     *
     * Construct a new fragment destination. This destination is not valid until you set the
     * Fragment via [setClassName].
     *
     * @param fragmentNavigator The [LauncherNavigator] which this destination will be
     *                          associated with. Generally retrieved via a [NavController]'s
     *                          [NavigatorProvider.getNavigator] method.
     */
    @NavDestination.ClassType(Launcher::class)
    public open class Destination
    public constructor(private val params: Launcher.LauncherParams?, fragmentNavigator: Navigator<out Destination>) :
        NavDestination(fragmentNavigator), FloatingWindow {
        private var _className: String? = null
        /**
         * The Launcher's class name associated with this destination
         *
         * @throws IllegalStateException when no Launcher class was set.
         */
        public val className: String
            get() {
                checkNotNull(_className) { "Launcher class was not set" }
                return _className as String
            }

        /**
         * Construct a new fragment destination. This destination is not valid until you set the
         * Fragment via [setClassName].
         *
         * @param navigatorProvider The [NavController] which this destination
         * will be associated with.
         */
        public constructor(params: Launcher.LauncherParams?, navigatorProvider: NavigatorProvider) : this(
            params,
            navigatorProvider.getNavigator(LauncherNavigator::class.java)
        )

        @CallSuper
        public override fun onInflate(context: Context, attrs: AttributeSet) {
            super.onInflate(context, attrs)
            context.resources.obtainAttributes(attrs, R.styleable.DialogFragmentNavigator).use { array ->
                val className = array.getString(R.styleable.DialogFragmentNavigator_android_name)
                className?.let { setClassName(it) }
            }
//            context.obtainStyledAttributes(com.example.app.R.styleable.LauncherNavigator).apply {
//                val graph =  getResourceId(com.example.app.R.styleable.LauncherNavigator_graph, 0)
//                if(graph == 0 ) {
//                    throw RuntimeException("must set a  app:graph=\"@navigation/my_app_navigation_graph\" in the launcher tag")
//                }
//                this@Destination.params?.let { params ->
//                    params.graph = graph
//                }
//                recycle()
//            }
        }

        /**
         * Set the Launcher class name associated with this destination
         * @param className The class name of the Launcher to show when you navigate to this
         *                  destination
         * @return this [Destination]
         */
        public fun setClassName(className: String): Destination {
            _className = className
            return this
        }

        override fun equals(other: Any?): Boolean {
            if (other == null || other !is Destination) return false
            return super.equals(other) && _className == other._className
        }

        override fun hashCode(): Int {
            var result = super.hashCode()
            result = 31 * result + _className.hashCode()
            return result
        }
    }

    private companion object {
        private const val TAG = "LauncherNavigator"
    }
}