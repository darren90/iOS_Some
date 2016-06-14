//
//  RRPlayerController.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RRPlayerController.h"
#import "RRPlayer.h"

@interface RRPlayerController()<RRVideoPlayerDelegate >
@end


@implementation RRPlayerController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.player playerWillAppear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self.player playerDidDisAppear];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.player = [[RRVideoPlayer alloc]init];
    self.player.view.frame = self.view.bounds;
    self.player.delegate = self;
    [self.view addSubview:self.player.view];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [path stringByAppendingPathComponent:@"22.mp4"];
//    [self.player playStreamUrl:[NSURL fileURLWithPath:urlStr]];

    NSURL *urlS = [NSURL fileURLWithPath:urlStr];
    NSURL *url = [NSURL URLWithString:@"http://cn-hbyc9-dx.acgvideo.com/vg2/9/92/4189690-1.mp4?expires=1465799400&ssig=RXsX85JEvJkUVrLIx1nQ_g&oi=2095617680&player=1&or=3662449045&rate=0"];
    //        url = [NSURL URLWithString:@"http://cn-hbjz1-dx.acgvideo.com/vg10/a/65/3905663.mp4?expires=1465818000&ssig=3vivDNjBQFXq6w5HfSnExw&oi=2095617680&player=1&or=3662449045&rate=0"];
    url = [NSURL URLWithString:@"http://cn-hbyc9-dx.acgvideo.com/vg2/9/92/4189690-1.mp4?expires=1465902300&ssig=nSgCUyHS-wbGcOQZq6tZAA&oi=2095617680&player=1&or=3662449045&rate=0"];
    url = [NSURL URLWithString:@"http://cn-hbyc9-dx.acgvideo.com/vg2/9/92/4189690-1.mp4?expires=1465913400&ssig=fknRFkmMwm-a0pMKKVvCrw&oi=2095617680&player=1&or=3662449045&rate=0"];
    [self.player playStreamUrl:url];
}

- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didControlByEvent:(VKVideoPlayerControlEvent)event
{
    if (self.player.view.isLockBtnEnable) {
        return;
    }
    
    switch (event) {
        case VKVideoPlayerControlEventTapDone:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [self unInstallPlayer];
            }];
        }
            break;
            
        default:
            break;
    }
    
    
}


-(void)dealloc
{
    [self unInstallPlayer];
}

#pragma mark - 卸载播放器
-(void)unInstallPlayer
{
    [_player pauseContent];
    [_player unInstallPlayer];
    _player.delegate = nil;
    [_player.view removeFromSuperview];
    _player.view = nil;
    _player = nil;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if (self.player.view.isLockBtnEnable) {
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            return  UIInterfaceOrientationMaskLandscapeRight;
        }else if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
            return UIInterfaceOrientationMaskLandscapeLeft;
        }
        return UIInterfaceOrientationMaskLandscape;
    }else{
        return UIInterfaceOrientationMaskLandscape;
    }
}


@end
