//
//  AdvertView.m
//  FileMaster
//
//  Created by Tengfei on 16/6/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "AdvertView.h"

@interface AdvertView ()<GADBannerViewDelegate>

@end

@implementation AdvertView
-(instancetype)init
{
    if (self = [super init]) {
        [self initliza];
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initliza];
    }
    return self;
}

-(void)initliza
{
    self.backgroundColor = MJColor(239, 239, 244);
    
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    self.bannerView = bannerView;
    self.clipsToBounds = YES;
    bannerView.frame = self.bounds;
    [self addSubview:self.bannerView];
 
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView.adUnitID = @"ca-app-pub-8145075793156354/9913856620";
//    req
//    self.bannerView.rootViewController = self.rootVc;
    self.bannerView.delegate = self;
    //        self.hidden = YES;
    
//    [self.bannerView loadRequest:[GADRequest request]];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    self.hidden = NO;
    //    if ([self.delegate respondsToSelector:@selector(AdvertFooterViewDidReceiveData:)]) {
    //        [self.delegate AdvertFooterViewDidReceiveData:self.model];
    //    }
    NSLog(@"--adViewDidReceiveAd-:successs");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"footer-error:%@",error);
//    if ([self.delegate respondsToSelector:@selector(AdvertFooterViewDidReceiveData:)]) {
//        [self.delegate AdvertFooterViewDidReceiveData:self.model];
//    }
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
 
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bannerView.frame = self.bounds;//CGRectMake((self.bounds.size.width - 320)/2, 0, 320, self.bounds.size.height);
    //    self.bannerView.adSize = kGADAdSizeBanner;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9b"];
    [self.bannerView loadRequest:request];
}
@end
