//
//  SmallPlayController.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SmallPlayController.h"
//#import "TFPlayerController.h"
#import "RRPlayerController.h"

@interface SmallPlayController ()
@property (nonatomic,weak)RRPlayerController *playVC;
@end

@implementation SmallPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RRPlayerController *playVC = [[RRPlayerController alloc]init];
    self.playVC = playVC;
    [self addChildViewController:self.playVC];
    [self.view addSubview:self.playVC.view];
    self.playVC.view.frame = CGRectMake(0, 80, self.view.frame.size.width, 300);
//    self.navigationController.navigationItem.
    self.playVC.view.clipsToBounds = YES;


    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
//    self.playVC.playUrl = [NSURL fileURLWithPath:urlStr];
    [self.playVC playStream:[NSURL fileURLWithPath:urlStr]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
    //    self.playVC.playUrl = [NSURL fileURLWithPath:urlStr];
    [self.playVC playChangeStreamUrl:[NSURL fileURLWithPath:urlStr]];
}


- (NSURL *)playCtrlGetCurrMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos
{
    NSURL *url ;
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"minion_06.mkv" withExtension:nil];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
    //        urlStr = [path stringByAppendingPathComponent:@"33.mov"];
    //        urlStr = [path stringByAppendingPathComponent:@"11.rmvb"];
    //        urlStr = [path stringByAppendingPathComponent:@"666.mkv"];
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
    [_playVC removeFromParentViewController];
    [_playVC unInstallPlayer];
    [_playVC.view removeFromSuperview];
    _playVC.view = nil;
    _playVC = nil;
    NSLog(@"----dealloc----");
}



@end
