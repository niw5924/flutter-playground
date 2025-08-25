package com.example.flutter_niw

import co.ab180.airbridge.flutter.AirbridgeFlutter
import android.app.Application

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        AirbridgeFlutter.initializeSDK(this, "flutterniwdev", "80a37e6edb594b18a107e3d4a32abe2f")
    }
}