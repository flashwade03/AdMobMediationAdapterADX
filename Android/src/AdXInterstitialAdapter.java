package com.bitmango.ads;

/**
 * Created by heechang on 2018. 4. 30..
 */
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.InterstitialAd;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.mediation.customevent.CustomEventInterstitial;
import com.google.android.gms.ads.mediation.customevent.CustomEventInterstitialListener;
import com.google.android.gms.ads.mediation.MediationAdRequest;
import com.google.unity.ads.*;

import android.util.Log;
import android.view.View;
import android.app.Activity;
import android.support.annotation.*;
import android.os.Bundle;
import android.content.Context;
import android.support.v4.media.session.PlaybackStateCompat;

@Keep
public final class ADXInterstitialAdapter implements CustomEventInterstitial{

    private InterstitialAd _interstitialAd;
    private String _unitId = "";
    private AdListener _listener = null;

    @Override
    public void onPause() {

    }

    @Override
    public void onResume() {

    }

    @Override
    public void onDestroy() {

    }

    @Override
    public void showInterstitial() {
        _interstitialAd.show();
    }

    @Override
    public void requestInterstitialAd(Context context, final CustomEventInterstitialListener listener, String serverParameter, MediationAdRequest mediationAdRequest, Bundle customEventExtras)  {
        this._unitId = serverParameter;
        Log.v("Ads", "RequestInterstitialAd :: unitId : "+this._unitId);
        _interstitialAd = new InterstitialAd(context);
        _interstitialAd.setAdUnitId(this._unitId);
        _listener = new AdListener() {
            @Override
            public void onAdLoaded() {
                listener.onAdLoaded();
            }

            @Override
            public void onAdFailedToLoad(int errorCode) {
                listener.onAdFailedToLoad(errorCode);
            }

            @Override
            public void onAdOpened() {
                listener.onAdOpened();
            }

            @Override
            public void onAdLeftApplication() {
                listener.onAdLeftApplication();
            }

            @Override
            public void onAdClosed() {
                listener.onAdClosed();
            }
        };

        _interstitialAd.setAdListener(_listener);

        AdRequest request = new AdRequest.Builder().build();
        _interstitialAd.loadAd(request);
    }
}
