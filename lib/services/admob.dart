import 'package:firebase_admob/firebase_admob.dart';

class AdmobService {
  static const adAppId = 'ca-app-pub-2340298263702925~1364095163';
  static const homeNativeAdId = 'ca-app-pub-2340298263702925/4728625101';
  static const interstitialAdId = 'ca-app-pub-2340298263702925/5305604947';

  static const testDevices = <String>[
    '86B9D2FFB0D5D9FC1F6B8BEB37A5DE77',
    'F0330A41B8F8D4153EACE15A7091C81A'
  ];

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    childDirected: false,
    nonPersonalizedAds: true,
    keywords: <String>['Book', 'Game', 'Photo Editor', 'Editor'],
    testDevices: testDevices,
  );

  static void init() {
    FirebaseAdMob.instance.initialize(appId: adAppId);
  }

  static InterstitialAd interstitial;

  static Future<void> loadInterstitial() async {
    print('Start loadInterstitial');
    if(interstitial != null) {
      await interstitial.dispose();
    }

    interstitial = InterstitialAd(
      adUnitId: interstitialAdId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );

    return interstitial.load();
  }

  static void showInterstitial() {
    print('Start showInterstitial');
    interstitial.show(
        anchorType: AnchorType.top,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0
    );
  }

  static NativeAd nativeAd = NativeAd(
    adUnitId: NativeAd.testAdUnitId,
    factoryId: 'adFactoryExample',
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("$NativeAd event $event");
    },
  );

}

