package com.codestagevn.gridpicture

import com.codestagevn.gridpicture.ads.HomeAdsFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.firebaseadmob.FirebaseAdMobPlugin


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(FirebaseAdMobPlugin())
        FirebaseAdMobPlugin.registerNativeAdFactory(flutterEngine, "home_native_ads", HomeAdsFactory(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        FirebaseAdMobPlugin.unregisterNativeAdFactory(flutterEngine, "home_native_ads");
        super.cleanUpFlutterEngine(flutterEngine)
    }
}