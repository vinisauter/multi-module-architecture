plugins {
    id ("com.android.dynamic-feature")
    id ("kotlin-android")
    id ("kotlin-kapt")
    id ("kotlin-parcelize")
    id ("com.google.devtools.ksp")
    id ("androidx.navigation.safeargs.kotlin")
}
android {
    compileSdk = (31)

    defaultConfig {
        minSdk= (21)
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildFeatures {
        viewBinding =  true
        dataBinding =  true
    }

    buildTypes {
        getByName("release"){
            isMinifyEnabled =  false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
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
    implementation(project(":app"))
    ksp(project(path = (":libraries:auto-service:processor")))

    testImplementation ("junit:junit:4.13.2")
    androidTestImplementation ("androidx.test.ext:junit:1.1.3")
    androidTestImplementation ("androidx.test.espresso:espresso-core:3.4.0")
    androidTestImplementation ("androidx.annotation:annotation:1.3.0")
}