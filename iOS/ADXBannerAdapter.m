//
//  ADXBannerAdapter.m
//  Unity-iPhone
//
//  Created by hcjung on 2018. 5. 3..
//

#import <Foundation/Foundation.h>
#import "ADXBannerAdapter.h"
#import "GADUPluginUtil.h"


static NSString *const customEventErrorDomain = @"com.bitmango.ads.ADXBannerAdapter";

@interface ADXBannerAdapter ()<GADBannerViewDelegate>

/// Defines where the ad should be positioned on the screen with a GADAdPosition.
@property(nonatomic, assign) GADAdPosition adPosition;

/// Defines where the ad should be positioned on the screen with a CGPoint.
@property(nonatomic, assign) CGPoint customAdPosition;

@end

@implementation ADXBannerAdapter

@synthesize delegate;
@synthesize bannerView;

#pragma mark GADCustomEventBanner implementaion

- (void)requestBannerAd:(GADAdSize)adSize parameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request{
    NSLog(@"%@ : requestBannerAd", customEventErrorDomain);
    NSString* _unitId = serverParameter;
    GADAdSize _adSize;
    UIDeviceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(currentOrientation)) {
        _adSize = kGADAdSizeSmartBannerPortrait;
    } else {
        _adSize = kGADAdSizeSmartBannerLandscape;
    }
    
    self.bannerView = [[GADBannerView alloc] initWithAdSize:_adSize];
    self.bannerView.delegate = self;
    self.bannerView.adUnitID = _unitId;
    self.bannerView.rootViewController = [GADUPluginUtil unityGLViewController];
    [self.bannerView loadRequest:[GADRequest request]];
    
}

#pragma mark GADCustomEventBannerDelegate implementaion
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"%@ : adViewDidReceiveAd", customEventErrorDomain);
    [self.delegate customEventBanner:self didReceiveAd:adView];
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%@ : adView:didFailToReceiveAdWithError: %@",customEventErrorDomain, [error localizedDescription]);
    [self.delegate customEventBanner:self didFailAd:error];
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"%@ : adViewWillLeaveApplication", customEventErrorDomain);
    [self.delegate customEventBannerWasClicked:self];
    [self.delegate customEventBannerWillLeaveApplication:self];
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"%@ : adViewWillPresentScreen", customEventErrorDomain);
    [self.delegate customEventBannerWillPresentModal:self];
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"%@ : adViewWillDismissScreen", customEventErrorDomain);
    [self.delegate customEventBannerWillDismissModal:self];
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"%@ : adViewDidDismissScreen", customEventErrorDomain);
    [self.delegate customEventBannerDidDismissModal:self];
}

@end


