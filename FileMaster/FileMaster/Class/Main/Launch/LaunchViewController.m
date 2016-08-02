//
//  LaunchViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/6/19.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "LaunchViewController.h"
#import "BaseTabBarController.h"
#import "AppDelegate.h"
@import GoogleMobileAds;

@interface LaunchViewController ()<GADInterstitialDelegate>
@property(nonatomic, strong) GADInterstitial *interstitial;


/**
 *  跳过按钮
 */
@property (nonatomic,weak)UIButton * jumpBtn;
/**NSTimer对象 */
@property (nonatomic,strong)NSTimer * timer;

//定时器的计数
@property (nonatomic,assign)NSInteger count;
@end

@implementation LaunchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"page_开屏广告"];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"page_开屏广告"];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;

    [self startNewGame];
    
    self.count = 6;//最先6S的等待时间，时间到，广告加载不出开，则不再进行加载
    [self addTimer];
}

- (void)startNewGame {
    [self createAndLoadInterstitial];
    
    // Set up a new game.
}

- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-8145075793156354/7414388623"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made.
    request.testDevices = @[ kGADSimulatorID, @"2077ef9a63d2b398840261c8221a0c9b" ];
    [self.interstitial loadRequest:request];
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    NSLog(@"--- load interstitial success");
    self.count = 6;

    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
    
    [self loadJumpView];
}

/// Called when an interstitial ad request completed without an interstitial to
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"--load interstitial---error--:%@",error);
    self.count = 3;
    [self loadJumpView];
}



- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    NSLog(@"interstitialWillPresentScreen");
}

/// Called when |ad| fails to present.
- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad
{
NSLog(@"interstitialDidFailToPresentScreen");
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
NSLog(@"interstitialWillDismissScreen");
//    [self destroyTimer];
    [self jump];
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
NSLog(@"interstitialDidDismissScreen");
}

/// Called just before the application will background or terminate because the user clicked on an
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad;
{
    NSLog(@"interstitialWillLeaveApplication");
}


-(void)loadJumpView
{
    [self destroyTimer];
    [self initiaz];
    [self addTimer];
}

-(void)initiaz
{
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.jumpBtn = jumpBtn;
    [jumpBtn setTitle:[NSString stringWithFormat:@"%lds 跳过",(long)self.count] forState:UIControlStateNormal];
    jumpBtn.frame = CGRectMake(KWidth - 110, 28, 100, 30);
    jumpBtn.layer.cornerRadius = 15;
    jumpBtn.clipsToBounds = YES;
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    jumpBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    [jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jumpBtn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
}

//撤销这个界面.
- (void)jump
{
    [self destroyTimer];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    BaseTabBarController *tabBarVc = [[BaseTabBarController alloc]init];

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UIViewController *keyVc = app.window.rootViewController;
//    if ([keyVc isKindOfClass:[BaseTabBarController class]]) {
//        [self destroyTimer];
//    }else{
        [self.view removeFromSuperview];
        app.window.rootViewController = tabBarVc;
        [app.window makeKeyAndVisible];
//    }
}


#pragma mark - 增加定时器
-(void)addTimer
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeCount) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //消息循环，添加到主线程
        //extern NSString* const NSDefaultRunLoopMode;  //默认没有优先级
        //extern NSString* const NSRunLoopCommonModes;  //提高优先级
    }
}

-(void)changeCount
{
//    NSString *ss =
    self.count--;
    if (self.count <= 0) {
        [self jump];
    }else{
        [self.jumpBtn setTitle:[NSString stringWithFormat:@"%lds 跳过",(long)self.count] forState:UIControlStateNormal];
    }
}

#pragma mark - 销毁定时器
-(void)destroyTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)dealloc
{
    if (_timer.isValid) {
        //让定时器失效
        [_timer invalidate];
        _timer = nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
