package com.auto.service.dynamic.instance

import android.app.Application
import android.content.Context
import com.auto.service.dynamic.FromModule
import com.auto.service.dynamic.SplitInstall
import com.google.android.play.core.splitinstall.SplitInstallSessionState
import com.google.android.play.core.splitinstall.model.SplitInstallSessionStatus
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlin.reflect.KClass

class SplitProvider(
    private val context: Context,
    private val provider: Provider = ServiceLoaderProvider,
) : Provider {
    override suspend fun <T : Any> getImpl(kClass: KClass<T>): T {
        val impl = try {
            provider.getImpl(kClass)
        } catch (throwable: Throwable) {
            val fromModule = kClass.annotations.find { it is FromModule } as? FromModule
            if (fromModule != null) {
                val splitInstall = SplitInstall(context)
                if (splitInstall.needsInstall(fromModule.value)) {
                    val installResult = splitInstall.requestInstall(fromModule.value)
                    if (installResult.status() == SplitInstallSessionStatus.INSTALLED) {
                        return provider.getImpl(kClass)
                    } else {
                        error("Illegal Split State:" + installResult.statusMessage())
                    }
                } else {
                    throw IllegalStateException(
                        "Module ${fromModule.value} is installed but implementation class where not found.",
                        throwable
                    )
                }
            } else {
                error("Please use @FromModule(\"module_name\") to specify witch module class ${kClass.simpleName} is implemented.")
            }
        }
        return impl
    }
}

fun SplitInstallSessionState.statusMessage(): String {
    return when (status()) {
        SplitInstallSessionStatus.CANCELED -> "CANCELED"
        SplitInstallSessionStatus.CANCELING -> "CANCELING"
        SplitInstallSessionStatus.DOWNLOADED -> "DOWNLOADED"
        SplitInstallSessionStatus.DOWNLOADING -> "DOWNLOADING"
        SplitInstallSessionStatus.FAILED -> "FAILED"
        SplitInstallSessionStatus.INSTALLED -> "INSTALLED"
        SplitInstallSessionStatus.INSTALLING -> "INSTALLING"
        SplitInstallSessionStatus.PENDING -> "PENDING"
        SplitInstallSessionStatus.REQUIRES_USER_CONFIRMATION -> "REQUIRES_USER_CONFIRMATION"
        SplitInstallSessionStatus.UNKNOWN -> "UNKNOWN"
        else -> "UNKNOWN(${status()})"
    }
}

fun SplitInstallSessionState.toMessage(): String {
    return " \n     sessionId: ${sessionId()}" +
            "\n     status: ${statusMessage()}" +
            "\n     errorCode: ${errorCode()}" +
            "\n     bytesDownloaded: ${bytesDownloaded()}" +
            "\n     totalBytesToDownload: ${totalBytesToDownload()}" +
            "\n     moduleNames: ${moduleNames()}" +
            "\n     languages: ${languages()}"
}

inline fun <reified T : Any> splitDeferred(app: Application): Lazy<Deferred<T>> {
    return lazy {
        GlobalScope.async(start = CoroutineStart.LAZY) {
            val split = SplitProvider(app)
            return@async split.getImpl(T::class)
        }
    }
}