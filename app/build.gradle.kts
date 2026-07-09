plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.aistudio.calculator.kxmpzq"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.aistudio.calculator.kxmpzq"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }
    
    applicationVariants.all {
        val variant = this
        val copyTask = tasks.register("copyAssetsFor${variant.name.capitalize()}", Copy::class.java) {
            from(project.rootDir)
            include("*.html")
            into("${project.projectDir}/src/main/assets")
        }
        variant.mergeAssetsProvider.get().dependsOn(copyTask)
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
