import extensions.addTestsDependencies

plugins {
    id(BuildPlugins.ANDROID_DYNAMIC_FEATURE)
    id(BuildPlugins.KOTLIN_JETBRAIN_KOTLIN_ANDROID)
    id(BuildPlugins.KOTLIN_KSP)
}
android {
    compileSdk = 31

    defaultConfig {
        minSdk = 21
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(
                    getDefaultProguardFile("proguard-android-optimize.txt"),
                    "proguard-rules.pro"
            )
        }
    }

    sourceSets {
        named("main") {
            java.srcDir("build/generated/ksp/${this.name}/kotlin/")
            java.srcDirs("build/generated/ksp/${this.name}/resources/")
        }
    }
}

dependencies {
    implementation(project(path = BuildModules.APP))
    ksp(project(path = BuildModules.Libraries.LIBRARIES_AUTO_SERVICE_PROCESSOR))

    testImplementation("junit:junit:4.13.2")
    addTestsDependencies()
}