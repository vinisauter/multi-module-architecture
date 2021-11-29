package android.injection.factory

/**
 * the InjectionFactory interface is a contract for
 */
interface InjectionFactory<T>{
    fun get(): T
}