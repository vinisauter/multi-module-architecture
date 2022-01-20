// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    id(GradlePluginId.DEV_TOOLS) version (GradlePluginVersion.DEV_TOOLS) apply (GradlePluginAPPLY.APPLY)
    id(GradlePluginId.ANDROID_APPLICATION) version (GradlePluginVersion.ANDROID_APPLICATION)apply (GradlePluginAPPLY.APPLY)
    id(GradlePluginId.ANDROID_LIBARY) version (GradlePluginVersion.ANDROID_LIBARY) apply (GradlePluginAPPLY.APPLY)
    id(GradlePluginId.KOTLIN_ANDROID) version (GradlePluginVersion.KOTLIN)apply (GradlePluginAPPLY.APPLY)
    id(GradlePluginId.DYNAMIC_FEATURE) version (GradlePluginVersion.DYNAMIC_FEATURE) apply (GradlePluginAPPLY.APPLY)
    id(GradlePluginId.SAFE_ARGS) version (GradlePluginVersion.SAFE_ARGS) apply (GradlePluginAPPLY.APPLY)
    id(GradlePluginId.KOTLIN_KAPT) version (GradlePluginVersion.KOTLIN) apply (GradlePluginAPPLY.APPLY)
}

tasks {
    register("type", Delete::class) {
        delete = setOf(rootProject.buildDir)
    }
}