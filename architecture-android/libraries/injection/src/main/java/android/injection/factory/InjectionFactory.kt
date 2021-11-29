package android.injection.factory

interface InjectionFactory<T>{
    fun get(): T
}