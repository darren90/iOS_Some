//
//  GDTAdvertView.m
//  FileMaster
//
//  Created by Tengfei on 2017/4/29.
//  Copyright © 2017年 tengfei. All rights reserved.
//
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#import "GDTAdvertView.h"
#import "GDTMobBannerView.h"
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <StoreKit/StoreKit.h>
#import "GDTMobBannerView.h"
//#import "InterstitialViewController.h"

@interface GDTAdvertView ()<GDTMobBannerViewDelegate>
{
    GDTMobBannerView *bannerView;
}
@end

@implementation GDTAdvertView

-(instancetype)initWithMovieList:(BOOL)isMovieList{
    self.isMovieList = isMovieList;
    if (self = [super init]) {
        [self initliza];
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initliza];
    }
    return self;
}


//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self initliza];
//    }
//    return self;
//}

-(void)initliza
{
    // Custom initialization
    NSString *appkey = @"1106126284";
    NSString *posId = @"1060622273752012";
    if(self.isMovieList){
        posId  = @"5050029283679858";
    }
    
    NSLog(@"Banner view init");
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0,0,GDTMOB_AD_SUGGEST_SIZE_728x90.width,GDTMOB_AD_SUGGEST_SIZE_728x90.height)
                                                      appkey:appkey placementId:posId];
    } else {
        bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0,0,GDTMOB_AD_SUGGEST_SIZE_320x50.width,GDTMOB_AD_SUGGEST_SIZE_320x50.height)
                                                      appkey:appkey placementId:posId];
    }
    
    
//    if (IS_OS_7_OR_LATER) {
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
//    }
    
    bannerView.delegate = self;
    bannerView.currentViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    bannerView.isAnimationOn = NO;
    bannerView.showCloseBtn = NO;
    bannerView.isGpsOn = YES;
    [bannerView loadAdAndShow];
    bannerView.isAnimationOn = YES;
    bannerView.interval = 10;
    bannerView.isGpsOn = YES;
    //    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
    //    [fK addSubview:bannerView];
    [self addSubview:bannerView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        bannerView.frame = CGRectMake(0,0,GDTMOB_AD_SUGGEST_SIZE_728x90.width,GDTMOB_AD_SUGGEST_SIZE_728x90.height);
    } else {
        bannerView.frame = CGRectMake(0,0,GDTMOB_AD_SUGGEST_SIZE_320x50.width,GDTMOB_AD_SUGGEST_SIZE_320x50.height);
    }
}

@end
