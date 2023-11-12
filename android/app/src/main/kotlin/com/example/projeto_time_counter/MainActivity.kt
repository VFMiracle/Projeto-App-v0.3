package com.example.projeto_time_counter

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    protected override fun onPause() {
        super.onPause()
        try {
            java.lang.Thread.sleep(200)
        } catch (e: InterruptedException) {
            e.printStackTrace()
        }
    }
}
