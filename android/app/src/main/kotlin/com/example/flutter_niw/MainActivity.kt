package com.example.flutter_niw

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import co.ab180.airbridge.flutter.AirbridgeFlutter

class MainActivity : FlutterActivity() {

    override fun onResume() {
        super.onResume()
        AirbridgeFlutter.trackDeeplink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
    }
}
