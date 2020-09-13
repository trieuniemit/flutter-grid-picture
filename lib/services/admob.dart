import 'package:firebase_admob/firebase_admob.dart';

class AdmobService {

  static const homeNativeAdId = 'ca-app-pub-2340298263702925/4728625101';
  static const testDevices = ['86B9D2FFB0D5D9FC1F6B8BEB37A5DE77'];

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    childDirected: false,
    nonPersonalizedAds: true,
    keywords: <String>['Book', 'Game', 'Photo Editor', 'Editor'],
    testDevices: testDevices,
  );

}

