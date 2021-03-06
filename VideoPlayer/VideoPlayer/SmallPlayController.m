//
//  SmallPlayController.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SmallPlayController.h"
#import "TFPlayerController.h"

@interface SmallPlayController ()<PlayerControllerDelegate>
@property (nonatomic,weak)TFPlayerController *playVC;
@end

@implementation SmallPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TFPlayerController *playerVC = [[TFPlayerController alloc]init];
    self.playVC = playerVC;
    [self addChildViewController:self.playVC];
    [self.view addSubview:self.playVC.view];
    self.playVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    self.playVC.delegate = self;
//    self.navigationController.navigationItem.
    self.playVC.view.clipsToBounds = YES;
}



- (NSURL *)playCtrlGetCurrMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos
{
    NSURL *url ;
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"minion_06.mkv" withExtension:nil];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
    //        urlStr = [path stringByAppendingPathComponent:@"33.mov"];
    //        urlStr = [path stringByAppendingPathComponent:@"11.rmvb"];
            urlStr = [path stringByAppendingPathComponent:@"66.mkv"];
    //        urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
    //         urlStr = [path stringByAppendingPathComponent:@"2018.mkv"];
    //        urlStr = [path stringByAppendingPathComponent:@"passenger_nginx.mov"];
    
    
    url = [NSURL fileURLWithPath:urlStr];
    return url;
}

- (NSURL *)playCtrlGetNextMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos
{
    NSString *uurl = @"http://data.vod.itc.cn/?new=/159/153/BLTbszdeSESKAORdntDxeB.mp4&vid=2369390&plat=17&mkey=filtjNDkZUYXjVnIMpwWi0UdTyx5u_eO&ch=tv&uid=1464595069948338&SOHUSVP=lApD3A56a0CT_mWoMjobOn6Lf_Q57FGagSolxETsgIQ&pt=5&prod=h5&pg=1&eye=0&cv=1.0.0&qd=68000&src=11050001&ca=4&cateCode=101&_c=1&appid=tv&oth=&cd=";
    
    return [NSURL URLWithString:uurl];
}

- (NSURL *)playCtrlGetPrevMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos
{
    NSString *uurl = @"http://data.vod.itc.cn/?new=/159/153/BLTbszdeSESKAORdntDxeB.mp4&vid=2369390&plat=17&mkey=filtjNDkZUYXjVnIMpwWi0UdTyx5u_eO&ch=tv&uid=1464595069948338&SOHUSVP=lApD3A56a0CT_mWoMjobOn6Lf_Q57FGagSolxETsgIQ&pt=5&prod=h5&pg=1&eye=0&cv=1.0.0&qd=68000&src=11050001&ca=4&cateCode=101&_c=1&appid=tv&oth=&cd=";
    
    return [NSURL URLWithString:uurl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self.playVC removeFromParentViewController];
    self.playVC.delegate = nil;
    [self.playVC.view removeFromSuperview];
//    self.playVC.view = nil;
    self.playVC = nil;
    NSLog(@"--small-dealoc--");
}

@end
