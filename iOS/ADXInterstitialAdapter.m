//
//  ADXInterstitialAdapter.m
//  Unity-iPhone
//
//  Created by hcjung on 2018. 5. 15..
//

#import <Foundation/Foundation.h>
#import "ADXInterstitialAdapter.h"
#import "GADUPluginUtil.h"

static NSString *const customEventErrorDomain = @"com.bitmango.ads.ADXInterstitialAdapter";

@interface ADXInterstitialAdapter () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation ADXInterstitialAdapter
@synthesize delegate;

#pragma mark GADCustomEventInterstitial implementation
- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request {
    NSLog(@"%@ : requestInterstitialAdWithParameter", customEventErrorDomain);
    NSLog(@"%@ : adkey : %@", customEventErrorDomain, serverParameter);
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:serverParameter];
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:[GADRequest request]];
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    NSLog(@"%@ : presentFromRootViewController", customEventErrorDomain);
    if ([self.interstitial isReady]) {
        UIViewController *unityController = [GADUPluginUtil unityGLViewController];
        [self.interstitial presentFromRootViewController:unityController];
    } else {
        NSLog(@"ADXInterstitialAdapter: Interstitial is not ready to be shown.");
    }
}

#pragma mark GADCustomEventInterstitialDelegate implementaion
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial{
    NSLog(@"%@ : interstitialDidReceivedAd", customEventErrorDomain);
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(nonnull GADRequestError *)errorCode {
    NSLog(@"%@ : didFailToLoadAdWithErrorCode", customEventErrorDomain);
    NSError *error = [NSError errorWithDomain:customEventErrorDomain
                                         code:errorCode
                                     userInfo:nil];
    [self.delegate customEventInterstitial:self didFailAd:error];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)interstitial {
    NSLog(@"%@ : interstitialWillPresentScreen", customEventErrorDomain);
    [self.delegate customEventInterstitialWillPresent:self];
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"%@ : interstitialWillDismissScreen", customEventErrorDomain);
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"%@ : interstitialDidDimissScreen", customEventErrorDomain);
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)interstitial {
    NSLog(@"%@ : interstitialWillLeaveApplication", customEventErrorDomain);
    [self.delegate customEventInterstitialWasClicked:self];
    [self.delegate customEventInterstitialWillLeaveApplication:self];
}

@end
