@file:Suppress("MemberVisibilityCanBePrivate", "unused", "SameParameterValue")

package com.core.logger

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.*
import java.util.logging.Filter
import java.util.logging.Level
import java.util.logging.LogRecord
import java.util.logging.Logger
import java.util.regex.Matcher
import java.util.regex.Pattern

object Logger {
    const val TAG = "ARCH"
    private var LOGGER: Logger? = null
    var logger: Logger?
        get() {
            if (LOGGER == null) {
                LOGGER = Logger.getLogger(TAG)
            }
            return LOGGER
        }
        set(value) {
            LOGGER = value
        }

    var fileHandler: LoggerFileHandler? = null
        set(value) {
            field?.let { logger?.removeHandler(field) }
            value?.let { logger?.addHandler(it) }
            field = value
        }

    val NO_FILTER: Filter? = null
    fun regexFilter(regex: String): Filter {
        return Filter { record: LogRecord ->
            val formatter = LoggerFormatter()
            val string: String = formatter.format(record)
            val regexPattern: Pattern = Pattern.compile(regex, Pattern.DOTALL)
            val matcher: Matcher = regexPattern.matcher(string)
            matcher.matches()
        }
    }

    var filter: Filter?
        get() {
            return logger?.filter
        }
        set(filter) {
            logger?.filter = filter
        }

    val hasFileHandler: Boolean
        get() {
            return fileHandler != null
        }

    fun timestamp(msg: String) {
        @Suppress("SpellCheckingInspection") val simpleFormat: DateFormat =
            SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale("pt", "BR"))
        log(Level.INFO, "" + simpleFormat.format(Date()) + " " + msg)
    }

    /**
     * Log the error.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param tag       A name for the logger
     * @param throwable Throwable associated with log message.
     */
    @Synchronized
    fun error(tag: String, throwable: Throwable) {
        log(
            Level.SEVERE,
            "$tag: -----------------   ERROR   -----------------"
        )
        log(Level.SEVERE, "" + tag + ": " + throwable.localizedMessage, throwable)
        log(
            Level.SEVERE,
            "$tag: ----------------- FIM ERROR -----------------"
        )
    }

    /**
     * Log the error.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param throwable Throwable associated with log message.
     */
    @Synchronized
    fun error(throwable: Throwable) {
        log(Level.SEVERE, "-----------------   ERROR   -----------------")
        log(Level.SEVERE, "" + throwable.localizedMessage, throwable)
        log(Level.SEVERE, "----------------- FIM ERROR -----------------")
    }

    /**
     * Log a WARNING message.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param msg The string message (or a key in the message catalog)
     */
    fun warn(msg: String) {
        log(Level.WARNING, "" + msg)
    }

    /**
     * Log a WARNING message.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param tag A name for the logger
     * @param msg The string message (or a key in the message catalog)
     */
    fun warn(tag: String, msg: String) {
        log(Level.WARNING, "$tag: $msg")
    }

    /**
     * Log a INFO message.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param tag A name for the logger
     * @param msg The string message (or a key in the message catalog)
     */
    fun log(tag: String, msg: String) {
        log(Level.INFO, "$tag: $msg")
    }

    /**
     * Log a INFO message.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param msg The string message (or a key in the message catalog)
     */
    fun log(msg: String) {
        log(Level.INFO, "" + msg)
    }

    /**
     * Log a message.
     *
     * If the logger is currently enabled for the given message
     * level then the given message is forwarded to all the
     * registered output Handler objects.
     *
     * @param level One of the message level identifiers, e.g., SEVERE
     * @param msg   The string message (or a key in the message catalog)
     */
    private fun log(level: Level, msg: String) {
        logger?.log(level, msg)
    }

    /**
     * Log a message, with associated Throwable information.
     *
     * If the logger is currently enabled for the given message
     * level then the given arguments are stored in a LogRecord
     * which is forwarded to all registered output handlers.
     *
     * Note that the thrown argument is stored in the LogRecord thrown
     * property, rather than the LogRecord parameters property.  Thus it is
     * processed specially by output Formatters and is not treated
     * as a formatting parameter to the LogRecord message property.
     *
     * @param level     One of the message level identifiers, e.g., SEVERE
     * @param msg       The string message (or a key in the message catalog)
     * @param throwable Throwable associated with log message.
     */
    private fun log(level: Level, msg: String, throwable: Throwable) {
        logger?.log(level, msg, throwable)
    }
}