package com.auto.service.dynamic.instance

import java.util.*
import kotlin.reflect.KClass

object ServiceLoaderProvider : Provider {
    @Suppress("UNCHECKED_CAST")// TODO
    override suspend fun <T : Any> getImpl(kClass: KClass<T>): T {
        try {
            val serviceLoader: ServiceLoader<T> =
                ServiceLoader.load(kClass.java, kClass.java.classLoader)
            return serviceLoader.iterator().next()
        } catch (e: Throwable) {
            val className = kClass.java.canonicalName
            throw IllegalStateException(
                "Class assigned as $className where not found.\n" +
                        "   Verify if module is installed\n" +
                        "   Verify if is in proguard or annotated with @androidx.annotation.Keep\n" +
                        "   Verify if $className is assignable from ${kClass.qualifiedName}\n" +
                        "   Verify if $className has a empty constructor", e
            )
        }
    }
}