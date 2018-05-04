//
//  ADXBannerAdapter.h
//  Unity-iPhone
//
//  Created by hcjung on 2018. 5. 3..
//
@import Foundation;
@import GoogleMobileAds;

@interface ADXBannerAdapter : NSObject<GADCustomEventBanner>
@property GADBannerView *bannerView;
@end
