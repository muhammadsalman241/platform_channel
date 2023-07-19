package com.example.platform_channel

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.example.platform_channel.RandomNumbers

class MainActivity: FlutterFragmentActivity() {

    private val RANDOM_CHANNEL = "com.your.app/random_num"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, RANDOM_CHANNEL).setMethodCallHandler(RandomNumbers())
    }

}
