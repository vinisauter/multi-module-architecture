plugins {
    id("com.android.application")
    id("kotlin-android")
    id("kotlin-kapt")
    id("kotlin-parcelize")
    id("com.google.devtools.ksp")
    id("androidx.navigation.safeargs.kotlin")
}

android {
    compileSdk = (31)

    defaultConfig {
        applicationId = ("com.example.app")
        minSdk = (21)
        targetSdk = (31)
        versionCode = (1)
        versionName = ("1.0")

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    buildFeatures {
        viewBinding = true
        dataBinding = true
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
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    sourceSets {
        named("main") {
            java.srcDir("build/generated/ksp/${this.name}/kotlin/")
            java.srcDirs("build/generated/ksp/${this.name}/resources/")
        }
    }


    fun MutableSet<String>.addAll(vararg items: String) {
        items.forEach { this.add(it) }
    }

    dynamicFeatures.addAll(
        ":modules:journey:home",
        ":modules:journey:login",
        ":modules:journey:profile",
        ":modules:structural:networking",
        ":modules:structural:networkingsecure",
        ":modules:structural:networkingsecurev2",
        ":modules:structural:storage",
        ":modules:structural:tagging",
        ":modules:structural:security"
    )
}

dependencies {

    api(project(path = (":libraries:auto-service:annotations")))
    ksp(project(path = (":libraries:auto-service:processor")))
    api(project(path = (":libraries:bug-finder")))
    api(project(path = (":libraries:injection")))

    api(project(path = (":engineering:interfaces:networking-interface")))
    api(project(path = (":engineering:interfaces:storage-interface")))
    api(project(path = (":engineering:interfaces:tagging-interface")))
    api(project(path = (":engineering:interfaces:security-interface")))

    api("androidx.core:core-ktx:1.7.0")
    api("androidx.activity:activity-ktx:1.4.0")
    api("androidx.fragment:fragment-ktx:1.4.0")

    api("androidx.appcompat:appcompat:1.3.1")
    api("androidx.constraintlayout:constraintlayout:2.1.1")
    api("com.google.android.material:material:1.4.0")
    api("com.google.android.play:core-ktx:1.8.1")

    api("androidx.navigation:navigation-fragment-ktx:2.4.0-beta02")
    api("androidx.navigation:navigation-ui-ktx:2.4.0-beta02")
    api("androidx.navigation:navigation-dynamic-features-fragment:2.4.0-beta02")

    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.3")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.4.0")
}