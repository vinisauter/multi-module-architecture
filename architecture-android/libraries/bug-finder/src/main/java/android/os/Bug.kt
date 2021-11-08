package android.os

import java.io.PrintWriter
import java.io.StringWriter

internal class Bug : Exception {
    var messageStackTrace: String? = null
        get() {
            if (field == null) {
                val sw = StringWriter()
                val pw = PrintWriter(sw, false)
                if (message != null) pw.append("# ").append(message).append(":\n")
                cause!!.printStackTrace(pw)
                pw.flush()
                pw.close()
                field = sw.toString()
            }
            return field
        }
        private set

    constructor(message: String?, cause: Throwable?) : super(message, cause) {}
    constructor(cause: Throwable?) : super(cause) {}
}