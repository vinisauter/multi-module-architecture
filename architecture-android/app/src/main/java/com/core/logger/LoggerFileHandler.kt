package com.core.logger

import android.Manifest
import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.FileProvider
import java.io.BufferedWriter
import java.io.File
import java.io.FileWriter
import java.io.IOException
import java.text.MessageFormat
import java.util.logging.*

class LoggerFileHandler(
    private val app: Application,
    private val file: File,
    private val authority: String,
    private val appVersion: String,  //BuildConfig.VERSION_CODE - BuildConfig.VERSION_NAME
    private val codeVersion: String,
    defaultFilter: Filter? = null,
    defaultFormatter: Formatter = LoggerFormatter(),
    defaultLevel: Level = Level.ALL,
) : Handler() {
    init {
        filter = defaultFilter
        formatter = defaultFormatter
        level = defaultLevel
    }

    private val sb = StringBuffer()

    @Synchronized
    override fun publish(record: LogRecord) {
        try {
            if (!isLoggable(record)) {
                return
            }
        } catch (ex: Exception) {
            // We don't want to throw an exception here, but we
            // report the exception to any registered ErrorManager.
            reportError(null, ex, ErrorManager.GENERIC_FAILURE)
            return
        }
        val msg: String = try {
            formatter.format(record)
        } catch (ex: Exception) {
            // We don't want to throw an exception here, but we
            // report the exception to any registered ErrorManager.
            reportError(null, ex, ErrorManager.FORMAT_FAILURE)
            return
        }
        try {
            sb.append(formatter.getHead(this))
            sb.append(msg)
            sb.append("\n")
        } catch (ex: Exception) {
            // We don't want to throw an exception here, but we
            // report the exception to any registered ErrorManager.
            reportError(null, ex, ErrorManager.WRITE_FAILURE)
        }
    }

    @Synchronized
    override fun flush() {
        Thread {
            try {
                publishToFile()
            } catch (ex: Exception) {
                // We don't want to throw an exception here, but we
                // report the exception to any registered ErrorManager.
                reportError(null, ex, ErrorManager.FLUSH_FAILURE)
            }
        }.start()
    }

    @Synchronized
    @Throws(SecurityException::class)
    override fun close() {
        Thread {
            try {
                publishToFile()
            } catch (ex: Exception) {
                // We don't want to throw an exception here, but we
                // report the exception to any registered ErrorManager.
                reportError(null, ex, ErrorManager.FLUSH_FAILURE)
            }
        }.start()
    }

    @Synchronized
    @Throws(IOException::class)
    fun publishToUri(): Uri {
        val file = publishToFile()
        return FileProvider.getUriForFile(app, authority, file)
    }

    @Synchronized
    @Throws(IOException::class)
    fun publishToFile(): File {
        val pendingLogs = sb.toString()
        sb.delete(0, sb.length)
        val fileExists = file.exists()
        if (!fileExists) {
            file.createNewFile()
        }
        val writer = BufferedWriter(FileWriter(file, true))
        if (!fileExists) {
            writer.write(MessageFormat.format("Installed by: {0}\n", installer))
            writer.write(MessageFormat.format("App version:  {0} \n", appVersion))
            writer.write(MessageFormat.format("Code version: {0}\n\n", codeVersion))
            writer.write(
                MessageFormat.format(
                    "Android version:    {0}{1}\n", Build.VERSION.SDK_INT,
                    if (isRooted(app)) "-ROOTED" else ""
                )
            )
            writer.write(MessageFormat.format("Device fingerprint: {0}\n", Build.FINGERPRINT))
            writer.write(MessageFormat.format("Device board:       {0}\n", Build.BOARD))
            writer.write(MessageFormat.format("Device host:        {0}\n\n", Build.HOST))
            writer.write(MessageFormat.format("Network:        {0}\n", networkClass))
            writer.write(MessageFormat.format("Active Network: {0}\n", activeNetwork))
            writer.newLine()
            writer.newLine()
        }
        writer.newLine()
        writer.append(pendingLogs)
        writer.close()
        return file
    }

    private val installer: String
        get() {
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
                    return app.packageManager.getInstallSourceInfo(app.packageName).installingPackageName!!
                @Suppress("DEPRECATION")
                return app.packageManager.getInstallerPackageName(app.packageName)!!

            } catch (t: Throwable) {
                return "Unknown"
            }
        }

    @get:SuppressLint("MissingPermission")
    private val networkClass: String
        get() {
            if (ActivityCompat.checkSelfPermission(
                    app,
                    Manifest.permission.READ_PHONE_STATE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return "READ_PHONE_STATE NOT_GRANTED"
            }
//            val mTelephonyManager =
//                app.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
//            val networkType = mTelephonyManager.networkType
//            if (networkType == TelephonyManager.NETWORK_TYPE_GPRS || networkType == TelephonyManager.NETWORK_TYPE_EDGE || networkType == TelephonyManager.NETWORK_TYPE_CDMA || networkType == TelephonyManager.NETWORK_TYPE_1xRTT || networkType == TelephonyManager.NETWORK_TYPE_IDEN) {
//                return "2G"
//            } else if (networkType == TelephonyManager.NETWORK_TYPE_UMTS || networkType == TelephonyManager.NETWORK_TYPE_EVDO_0 || networkType == TelephonyManager.NETWORK_TYPE_EVDO_A || networkType == TelephonyManager.NETWORK_TYPE_HSDPA || networkType == TelephonyManager.NETWORK_TYPE_HSUPA || networkType == TelephonyManager.NETWORK_TYPE_HSPA || networkType == TelephonyManager.NETWORK_TYPE_EVDO_B || networkType == TelephonyManager.NETWORK_TYPE_EHRPD || networkType == TelephonyManager.NETWORK_TYPE_HSPAP) {
//                return "3G"
//            } else if (networkType == TelephonyManager.NETWORK_TYPE_LTE) {
//                return "4G"
//            } else if (networkType == TelephonyManager.NETWORK_TYPE_NR) {
//                return "5G"
//            } else if (networkType == TelephonyManager.NETWORK_TYPE_GSM) {
//                return "GSM"
//            }
//            return "Unknown - $networkType"
            return "Unknown"
        }

    @get:SuppressLint("MissingPermission")
    private val activeNetwork: String
        get() {
            if (ActivityCompat.checkSelfPermission(
                    app,
                    Manifest.permission.ACCESS_NETWORK_STATE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return "ACCESS_NETWORK_STATE NOT_GRANTED"
            }
            var activeNetwork = ""
            val cm = app.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val network = cm.activeNetwork
                if (network != null) {
                    val capabilities = cm.getNetworkCapabilities(network)
                    activeNetwork = capabilities?.toString() ?: "UNKNOWN"
                }
            } else {
//                val networkInfo = cm.activeNetworkInfo
//                activeNetwork = if (networkInfo != null) {
//                    when (val type = networkInfo.type) {
//                        ConnectivityManager.TYPE_WIFI -> {
//                            "WIFI"
//                        }
//                        ConnectivityManager.TYPE_MOBILE -> {
//                            "MOBILE"
//                        }
//                        ConnectivityManager.TYPE_VPN -> {
//                            "VPN"
//                        }
//                        else -> {
//                            "UNKNOWN - $type"
//                        }
//                    }
//                } else {
//                    "UNKNOWN"
//                }
            }
            return activeNetwork
        }

    companion object {
        private fun isEmulator(context: Context): Boolean {
            @SuppressLint("HardwareIds") val androidId =
                Settings.Secure.getString(context.contentResolver, "android_id")
            return "sdk" == Build.PRODUCT || "google_sdk" == Build.PRODUCT || androidId == null
        }

        private fun isRooted(context: Context): Boolean {
            val isEmulator = isEmulator(context)
            val buildTags = Build.TAGS
            return if (!isEmulator && buildTags != null && buildTags.contains("test-keys")) {
                true
            } else {
                var file = File("/system/app/Superuser.apk")
                if (file.exists()) {
                    true
                } else {
                    @Suppress("SpellCheckingInspection")
                    file = File("/system/xbin/su")
                    !isEmulator && file.exists()
                }
            }
        }
    }
}