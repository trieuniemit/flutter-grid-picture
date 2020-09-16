package com.codestagevn.gridpicture.ads;

import android.content.Context;
import android.view.View;

import com.codestagevn.gridpicture.R;
import com.codestagevn.gridpicture.ads.base.AdsTemplateView;
import com.codestagevn.gridpicture.ads.base.NativeAdsStyle;
import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;
import io.flutter.plugins.firebaseadmob.FirebaseAdMobPlugin.NativeAdFactory;
import java.util.Map;

public class HomeAdsFactory implements NativeAdFactory {

    private Context context;

    public HomeAdsFactory(Context context) {
        this.context = context;
    }

    @Override
    public UnifiedNativeAdView createNativeAd(UnifiedNativeAd nativeAd, Map<String, Object> customOptions) {

        AdsTemplateView adsTemplateView = new AdsTemplateView(context);
        adsTemplateView.setNativeAd(nativeAd);
        adsTemplateView.setVisibility(View.VISIBLE);
        NativeAdsStyle styles = new NativeAdsStyle.Builder().build();
        adsTemplateView.setStyles(styles);
        adsTemplateView.setTemplateType(R.layout.ads_medium_template_view);

        return  adsTemplateView.getNativeAdView();
    }
}