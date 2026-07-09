#!/bin/bash
mkdir -p app/src/main/java/com/aistudio/calculator/kxmpzq
mkdir -p app/src/main/res/values

cat << 'INNER_EOF' > settings.gradle.kts
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "Dragon Calculator"
include(":app")
INNER_EOF

cat << 'INNER_EOF' > build.gradle.kts
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.20")
    }
}
INNER_EOF

cat << 'INNER_EOF' > gradle.properties
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
kotlin.code.style=official
INNER_EOF

cat << 'INNER_EOF' > app/build.gradle.kts
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
INNER_EOF

cat << 'INNER_EOF' > app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application
        android:allowBackup="true"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat.Light.NoActionBar">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
INNER_EOF

cat << 'INNER_EOF' > app/src/main/java/com/aistudio/calculator/kxmpzq/MainActivity.kt
package com.aistudio.calculator.kxmpzq

import android.annotation.SuppressLint
import android.os.Bundle
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val webView = WebView(this)
        setContentView(webView)

        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.settings.cacheMode = WebSettings.LOAD_NO_CACHE
        webView.webViewClient = WebViewClient()
        
        webView.loadUrl("file:///android_asset/index.html")
    }
}
INNER_EOF

cat << 'INNER_EOF' > app/src/main/res/values/strings.xml
<resources>
    <string name="app_name">Dragon Calculator</string>
</resources>
INNER_EOF

echo "Done"
