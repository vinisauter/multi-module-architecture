import com.google.devtools.ksp.symbol.KSAnnotation
import com.google.devtools.ksp.symbol.KSClassDeclaration
import java.io.OutputStream
import java.io.PrintWriter
import java.io.StringWriter
import kotlin.reflect.KClass

fun OutputStream.append(str: String) {
    this.write(str.toByteArray())
}

fun OutputStream.appendLn(str: String) {
    this.append("$str\n")
}

fun Throwable.asString(): String {
    val sw = StringWriter()
    val pw = PrintWriter(sw)
    printStackTrace(pw)
    return sw.toString()
}

fun <T : Annotation> KSClassDeclaration.getAnnotations(annotationKClass: KClass<T>): Sequence<KSAnnotation> {
    return this.annotations.filter {
        it.shortName.getShortName() == annotationKClass.simpleName &&
                it.annotationType.resolve().declaration.qualifiedName?.asString() == annotationKClass.qualifiedName
    }
}