//
//  TFVideoPlayerViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFMoviePlayerViewController.h"
#import "DBTools.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface TFMoviePlayerViewController ()<AVAudioSessionDelegate,TFVideoPlayerDelegate>

/**
 *  是否播放的是本地已经下载的文件，YES：是，NO：可以不用传递
 */
@property (nonatomic,assign)BOOL isPlayLocalFile;
@end

@implementation TFMoviePlayerViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.player playerWillAppear];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player playerDidDisAppear];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //程序被强制关闭的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleInterruption:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
    //观看中，接收到电话
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    [[AVAudioSession sharedInstance] setDelegate:self];
    
    self.isPlayLocalFile = YES;//默认播放本地视频
    
    self.player = [[TFVideoPlayer alloc]init];
    self.player.view.frame = self.view.bounds;
    self.player.delegate = self;
    [self.view addSubview:self.player.view];
 
    [self playVideo];
}

- (void)handleInterruption:(NSNotification *)notice{
    /* For example:
     [[NSNotificationCenter defaultCenter] addObserver: myObject
     selector:    @selector(handleInterruption:)
     name:        AVAudioSessionInterruptionNotification
     object:      [AVAudioSession sharedInstance]];
     */
    [self.player pauseContent];
    [self saveSeekDuration];
}

-(void)playVideo
{
    NSURL *uurl ;
    if (self.isPlayLocalFile) { //播放本地视频

        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES) firstObject];
        NSString *url = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",self.playLocalUrl]];
        self.player.isPlayLocalFile = YES;
         uurl = [NSURL fileURLWithPath:url];
    }else{//播网络视频
        //        self.player.isPlayLocalFile = NO;
        //        [self playStream:[NSURL URLWithString:self.listModel.m3u8.url]];
    }

    [self playStream:uurl];
}

#pragma mark - 保存看剧时间
- (void)saveSeekDuration{
    [DBTools saveSeekDuration:self.topTitle duration:self.player.currentDuraion];
}

/**
 *  小屏播放器要用到
 *
 *  @param url 播放地址
 */
- (void)playStream:(NSURL*)url
{
    [self.player playStreamUrl:url title:self.topTitle seekToPos:[DBTools getSeekDuration:self.topTitle]];
}

-(void)playChangeStreamUrl:(NSURL *)url
{
    [self.player playChangeStreamUrl:url title:self.topTitle seekToPos:[DBTools getSeekDuration:self.topTitle]];
}

- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event
{
    if (self.player.view.isLockBtnEnable) {
        return;
    }
    
    switch (event) {
        case TFVideoPlayerControlEventTapDone:
        {
            [self.player pauseContent];
            [self saveSeekDuration];
            [self dismissViewControllerAnimated:YES completion:^{
                [self unInstallPlayer];
            }];
        }
            break;
        case TFVideoPlayerControlEventPause:
        {
            [self.player pauseContent];

        }
            break;
        default:
            break;
    }
    
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self unInstallPlayer];
}

#pragma mark - 卸载播放器
-(void)unInstallPlayer
{
    [[AVAudioSession sharedInstance] setDelegate:nil];
    [_player pauseContent];
    [_player unInstallPlayer];
    _player.delegate = nil;
    [_player.view removeFromSuperview];
    _player.view = nil;
    _player = nil;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
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
