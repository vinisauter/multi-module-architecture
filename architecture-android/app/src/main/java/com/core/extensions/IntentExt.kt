@file:Suppress("unused")

package com.core.extensions

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import androidx.fragment.app.Fragment
import kotlin.reflect.KClass

inline fun <reified A : Activity> Context.start(configIntent: Intent.() -> Unit = {}) {
    startActivity(Intent(this, A::class.java).apply(configIntent))
}

@Throws(ActivityNotFoundException::class)
inline fun <reified T : Activity> KClass<T>.intent(): Intent {
//    mPackage = pkg.getPackageName()
//    mClass = cls.getName()
    return Intent(T::class.java.canonicalName)
}

@Throws(ActivityNotFoundException::class)
inline fun Context.startActivity(action: String, configIntent: Intent.() -> Unit = {}) {
    startActivity(Intent(action).apply(configIntent))
}

inline fun <reified A : Activity> Context.intent() {
    Intent(this, A::class.java)
}

inline fun <reified T : Any> Activity.extra(name: String, default: T): T {
    val value = intent?.extras?.get(name)
    return if (value is T) value else default
}

inline fun <reified T : Any> Fragment.extra(name: String, default: T): T {
    val value = arguments?.get(name)
    return if (value is T) value else default
}

inline fun <reified T : Any> Intent.extra(key: String, value: T? = null): Intent {
    when (value) {
        is Byte -> putExtra(key, value)
        is Char -> putExtra(key, value)
        is Int -> putExtra(key, value)
        is Long -> putExtra(key, value)
        is Float -> putExtra(key, value)
        is Short -> putExtra(key, value)
        is Double -> putExtra(key, value)
        is Boolean -> putExtra(key, value)
        is String -> putExtra(key, value)
        is CharSequence -> putExtra(key, value)
        is BooleanArray -> putExtra(key, value)
        is ByteArray -> putExtra(key, value)
        is CharArray -> putExtra(key, value)
        is DoubleArray -> putExtra(key, value)
        is FloatArray -> putExtra(key, value)
        is IntArray -> putExtra(key, value)
        is LongArray -> putExtra(key, value)
        is ShortArray -> putExtra(key, value)
        is Bundle -> putExtra(key, value)
//      TODO add lint rule
//       put only primitives a extras to avoid TransactionTooLargeException
//        is Parcelable -> putExtra(key, value)
//        is Serializable -> putExtra(key, value)
        is Array<*> -> {
            @Suppress("UNCHECKED_CAST")
            when {
//              TODO add lint rule
//               put only primitives a extras to avoid TransactionTooLargeException
//                value.isArrayOf<Parcelable>() -> b.putParcelableArray(k, v as Array<out Parcelable>)
                value.isArrayOf<CharSequence>() -> putExtra(key, value as Array<out CharSequence>)
                value.isArrayOf<String>() -> putExtra(key, value as Array<out String>)
                else -> error("Unsupported extra component (${T::class.java})")
            }
        }
        else -> error("Unsupported extra component (${T::class.java})")
    }
    return this
}

/**
 * Add the [Intent.FLAG_ACTIVITY_CLEAR_TASK] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.clearTask(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK) }

/**
 * Add the [Intent.FLAG_ACTIVITY_CLEAR_TOP] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.clearTop(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP) }

/**
 * Add the [Intent.FLAG_ACTIVITY_NEW_DOCUMENT] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.newDocument(): Intent = apply {
    addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT)
}

/**
 * Add the [Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
@Suppress("SpellCheckingInspection")
fun Intent.excludeFromRecents(): Intent =
    apply { addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS) }

/**
 * Add the [Intent.FLAG_ACTIVITY_MULTIPLE_TASK] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.multipleTask(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_MULTIPLE_TASK) }

/**
 * Add the [Intent.FLAG_ACTIVITY_NEW_TASK] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.newTask(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) }

/**
 * Add the [Intent.FLAG_ACTIVITY_NO_ANIMATION] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.noAnimation(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION) }

/**
 * Add the [Intent.FLAG_ACTIVITY_NO_HISTORY] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.noHistory(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY) }

/**
 * Add the [Intent.FLAG_ACTIVITY_SINGLE_TOP] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
fun Intent.singleTop(): Intent = apply { addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP) }

/**
 * Add the [Intent.FLAG_ACTIVITY_SINGLE_TOP] flag to the [Intent].
 * Add the [Intent.FLAG_ACTIVITY_NEW_TASK] flag to the [Intent].
 * Add the [Intent.FLAG_ACTIVITY_CLEAR_TASK] flag to the [Intent].
 *
 * @return the same intent with the flag applied.
 */
@Suppress("SpellCheckingInspection")
fun Intent.clearStack(): Intent = apply {
    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
}

inline val Context.displayMetrics: android.util.DisplayMetrics
    get() = resources.displayMetrics
inline val Context.configuration: Configuration
    get() = resources.configuration
inline val Configuration.portrait: Boolean
    get() = orientation == Configuration.ORIENTATION_PORTRAIT
inline val Configuration.landscape: Boolean
    get() = orientation == Configuration.ORIENTATION_LANDSCAPE
inline val Configuration.long: Boolean
    get() = (screenLayout and Configuration.SCREENLAYOUT_LONG_YES) != 0