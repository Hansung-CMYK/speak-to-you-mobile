package com.cmky.ego.ego  // ← 실제 패키지 이름으로 조정하세요

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app.channel.audio"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "setMicMute" -> {
                    val mute = call.argument<Boolean>("mute") ?: false
                    val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                    audioManager.isMicrophoneMute = mute
                    result.success(null)
                }
                "setSpeakerMute" -> {
                    val mute = call.argument<Boolean>("mute") ?: false
                    val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                    audioManager.isSpeakerphoneOn = !mute
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
