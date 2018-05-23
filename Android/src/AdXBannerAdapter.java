package com.bitmango.ads;

/**
 * Created by hcjung on 2018. 4. 26..
 */
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.mediation.MediationAdRequest;
import com.google.android.gms.ads.mediation.MediationAdapter;
import com.google.android.gms.ads.mediation.MediationBannerAdapter;
import com.google.android.gms.ads.mediation.MediationBannerListener;
import com.google.android.gms.ads.mediation.MediationInterstitialAdapter;
import com.google.android.gms.ads.mediation.MediationInterstitialListener;
import com.google.android.gms.ads.mediation.customevent.CustomEventBanner;
import com.google.android.gms.ads.mediation.customevent.CustomEventBannerListener;
import com.google.android.gms.ads.reward.RewardItem;
import com.google.android.gms.ads.reward.mediation.MediationRewardedVideoAdAdapter;
import com.google.android.gms.ads.reward.mediation.MediationRewardedVideoAdListener;
import com.google.unity.ads.*;

import android.view.View;
import android.app.Activity;
import android.support.annotation.*;
import android.os.Bundle;
import android.content.Context;
import android.support.v4.media.session.PlaybackStateCompat;
import android.util.Log;
import android.widget.RelativeLayout;
import android.view.ViewGroup;

@Keep
public final class ADXBannerAdapter implements CustomEventBanner {

    private boolean _isInitialized;
    private AdView _bannerview;
    private AdSize _adSize;
    private MediationBannerListener _bannerListener;
    private Activity activity = null;
    private RelativeLayout mWrappedAdView;
    @Override
    public void onDestroy() {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (_bannerview != null)
                    _bannerview.destroy();
                else
                    Log.v("ADXBannerAdapter", "destroy::banner view is null");
            }
        });
    }

    @Override
    public void onPause() {
        _bannerview.pause();
    }

    @Override
    public void onResume() {
        _bannerview.resume();
    }

    @Override
    public void requestBannerAd(final Context context, final CustomEventBannerListener listener, String serverParameter, final AdSize adsize, MediationAdRequest adRequest, Bundle mediationExtras) {
        activity = (Activity)context;

        Log.v("ADXBannerAdapter", "size : "+adsize.toString());
        Log.v("ADXBannerAdapter", "request::server parameter : "+serverParameter);
        String adunit = serverParameter;

        CustomEventBannerListener bannerlistener = listener;
        AdListener adListener = new AdListener(){

            @Override
            public void onAdFailedToLoad(int error) {
                Log.v("ADXBannerAdapter", "onAdFailedToLoad");
                listener.onAdFailedToLoad(error);
            }

            @Override
            public void onAdLoaded() {
                Log.v("ADXBannerAdaper", "onAdLoaded");
                listener.onAdLoaded(_bannerview);
            }

            @Override
            public void onAdLeftApplication() {
                Log.v("ADXBannerAdapter", "onAdLeftApplication");
                onAdClicked();
                listener.onAdLeftApplication();
            }

            @Override
            public void onAdClicked() {
                Log.v("ADXBannerAdapter", "onAdClicked");
                listener.onAdClicked();
            }

            @Override
            public void onAdClosed() {
                Log.v("ADXBannerAdapter", "onAdClosed");
                listener.onAdClosed();
            }

            @Override
            public void onAdOpened() {
                Log.v("ADXBannerAdapter", "onAdOpened");
                listener.onAdOpened();
            }
        };

        AdRequest request = new AdRequest.Builder().build();
        _bannerview = new AdView(context);
        if (_bannerview == null) {
            Log.v("ADXBannerAdapter", "request::bannerview is null");
        }

        _bannerview.setAdUnitId(adunit);
        int widthInPixels = adsize.getWidthInPixels(context);
        int heightInPixels = adsize.getHeightInPixels(context);
        _bannerview.setAdSize(adsize);
        _bannerview.setAdListener(adListener);
        Log.v("ADXBannerAdapter", "AdUnit : "+adunit);
        _bannerview.loadAd(request);

    }
}


