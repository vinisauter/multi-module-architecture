package android.injection.factory

interface Factory<T>{
    fun get(): T
}