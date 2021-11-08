package com.app.logger

import java.io.PrintWriter
import java.io.StringWriter
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.*
import java.util.logging.Formatter
import java.util.logging.LogRecord
import kotlin.math.min

class LoggerFormatter : Formatter() {

    override fun format(record: LogRecord): String {
        val dt: DateFormat = SimpleDateFormat("HH:mm:ss", Locale.getDefault())
        val date = Date()
        date.time = record.millis
        var message = formatMessage(record)
        var throwable = ""
        if (record.thrown != null) {
            throwable = getThrowableAsString(record.thrown)
        }
        val maxLength = 5000
        message = message.substring(0, min(message.length, maxLength))
        return String.format(
            "%s %s/%s: %s %s",
            dt.format(date),
            record.level.name[0],
            record.loggerName,
            message,
            throwable
        )
    }

    companion object {
        fun getThrowableAsString(throwable: Throwable): String {
            val sw = StringWriter()
            throwable.printStackTrace(PrintWriter(sw))
            return sw.toString()
        }
    }
}