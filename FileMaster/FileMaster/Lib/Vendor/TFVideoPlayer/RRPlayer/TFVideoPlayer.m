//
//  TFVideoPlayer.m
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFVideoPlayer.h"

#import "TFUtilities.h"
#import "TFVSegmentSlider.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ForwardBackView.h"
#import "UIAlertView+Blocks.h"
#import "UIView+RRFoundation.h"


#define KTFPlayer_Btn_Play [UIImage imageNamed:@"VKVideoPlayer_play.png"]
#define KTFPlayer_Btn_pause [UIImage imageNamed:@"VKVideoPlayer_pause.png"]
#define degreesToRadians(x) (M_PI * x / 180.0f)

#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self;


@interface TFVideoPlayer ()<TFVideoPlayerViewDelegate>
{
    long               mDuration;
    long               mCurPostion;
    NSTimer            *mSyncSeekTimer;
    
    BOOL isEndFast;//快进结束
    NSNumber * fastNum;
}

@property (nonatomic, assign) BOOL progressDragging;


/** 上一次的观看时间 单位：秒 */
@property (nonatomic,assign)long lastWatchPos;


//音轨的数组
@property (nonatomic,strong)NSMutableArray * trackArray;


@end

@implementation TFVideoPlayer

//异步线程更改
void TFRUN_ON_UI_THREAD(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

static   TFVideoPlayer *tfVideoPlayer = nil;

+(TFVideoPlayer *) sharedPlayer
{
    @synchronized(self){
        if (tfVideoPlayer == nil) {
            tfVideoPlayer = [[self alloc] init];
        }
    }
    return  tfVideoPlayer;
}

- (id)init {
    self = [super init];
    if (self) {
        self.view = [TFVideoPlayerView videoPlayerView];
        [self initialize];
    }
    return self;
}

//-(void)setIsPlayLocalFile:(BOOL)isPlayLocalFile
//{
//    _isPlayLocalFile = isPlayLocalFile;
//    self.view.isPlayLocalFile = isPlayLocalFile;
//}

- (id)initWithVideoPlayerView:(TFVideoPlayerView*)videoPlayerView {
    self = [super init];
    if (self) {
        self.view = videoPlayerView;
        [self initialize];
    }
    return self;
}

#pragma mark - initialize
- (void)initialize {
//    [self initializeProperties];
//    [self initializePlayerView];
//    [self addObservers];
    self.view.delegate = self;
//    self.view.isPlayLocalFile = self.isPlayLocalFile;
    if (!self.mMPayer) {
        self.mMPayer = [VMediaPlayer sharedInstance];
        [self.mMPayer setupPlayerWithCarrierView:self.view.carrier withDelegate:self];
        [self setupObservers];
    }
}

-(void)setIsPlayLocalFile:(BOOL)isPlayLocalFile
{
    _isPlayLocalFile = isPlayLocalFile;
    self.view.isPlayLocalFile = _isPlayLocalFile;
}

#pragma mark - 第一次播放视频
-(void)playStreamUrl:(NSURL*)url title:(NSString*)title seekToPos:(long)pos
{
    NSLog(@"---playStreamUrl---");
    __weak __typeof(self)weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        long lastPos = 0;
        [weakSelf quicklyPlayMovie:url title:title seekToPos:pos];
//    });
}

#pragma mark - 播放中途，切换视频URL重新进行播放（切换清晰度，切换剧集）
-(void)playChangeStreamUrl:(NSURL *)url title:(NSString*)title seekToPos:(long)pos
{
    [self quicklyReplayMovie:url title:title seekToPos:pos];
}


//-(void)

- (void)setupObservers
{
    NSNotificationCenter *def = [NSNotificationCenter defaultCenter];
    [def addObserver:self selector:@selector(applicationDidEnterForeground:) name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
    [def addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
}

- (void)applicationDidEnterForeground:(NSNotification *)notification
{
    if (![self.mMPayer isPlaying]) {
//        [self.mMPayer setVideoShown:YES];
//        [self.mMPayer start];

//        WS(weakSelf);
//        TFRUN_ON_UI_THREAD(^{
//            [weakSelf.view.startPause setImage:KTFPlayer_Btn_pause forState:UIControlStateNormal];
//        });
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    if ([self.mMPayer isPlaying]) {
        [self.mMPayer pause];
//        [self.mMPayer setVideoShown:NO];
    }
}



///

#pragma mark - TFVideoPlayerViewDelegate
- (void)captionButtonTapped {
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventTapCaption];
    }
}

- (void)playButtonPressed {
    [self playContent];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventPlay];
    }
}

- (void)pauseButtonPressed {
    [self pauseContent];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventPause];
    }
}

-(void)progressSliderUp:(float)value
{
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:(long)(value * mDuration)];
    if (!self.mMPayer.isPlaying) {//没有播放的时候，拖动进度条后，进行播放
        [self.mMPayer start];
    }
}

-(long)getCurrentDuration
{
//    mDuration = [self.mMPayer getCurrentPosition];
    return mCurPostion;
}

//得到总的视频时长
-(long)getTotalDuration
{
    return [self.mMPayer getDuration];
}

-(void)progressSliderDownAction
{
    self.progressDragging = YES;
}

-(void)progressSliderTapped:(CGFloat)percentage
{
    long seek = percentage * mDuration;
//    self.curPosLbl.text = [TFUtilities timeToHumanString:seek];
    NSLog(@"NAL 2BVC &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& seek = %ld", seek);
//    [self.view startActivityWithMsg:@"Buffering"];
//    [self.mMPayer seekTo:seek];
    [self moveProgressWithTime:time];
}

-(void)endFastWithTime:(long)time
{
    [self moveProgressWithTime:time];
}

-(void)moveProgressWithTime:(long)time
{
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:time];

    if (!self.mMPayer.isPlaying) {//没有播放的时候，拖动进度条后，进行播放
        [self.mMPayer start];
    }
}

- (void)playContent {
    WS(weakSelf);
    TFRUN_ON_UI_THREAD(^{
        [weakSelf.mMPayer start];
    });
}

- (void)pauseContent {
//    [self pauseContent:NO completionHandler:nil];
    [self.mMPayer pause];
}

-(void)doneButtonTapped
{

    [self quicklyStopMovie];

    [self unSetupObservers];
    //    [mMPayer unSetupPlayer];
    BOOL b = [_mMPayer unSetupPlayer];
    NSLog(@"%d",b);

    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventTapDone];
    }
}

#pragma mark --------分割线-----------------
#pragma mark - 分享
-(void)shareButtonTapped
{
#warning TODO - 
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventShare];
    }
}

#pragma mark - 选集
-(void)selectMenuButtonTapped
{
#warning TODO -
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventSelectMenu];
    }
}


#pragma mark - 弹幕按钮
-(void)isAllowDanmu
{
#warning TODO -
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoplayercontroleventDanMu];
    }
}

-(void)clarityButtonTapped
{
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoplayercontroleventClarity];
    }
}

-(void)changeTrackTapped
{
    UIAlertView *alertView = [UIAlertView
                              showWithTitle:@"Audio Trackers Picker"
                              message:nil
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:self.trackArray
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  NSInteger firstOBIndex = [alertView firstOtherButtonIndex];
                                  NSInteger lastOBIndex = firstOBIndex + [self.trackArray count];
                                  if (buttonIndex >= firstOBIndex && buttonIndex < lastOBIndex) {
                                      [self.mMPayer setAudioTrackWithArrayIndex:(int)(buttonIndex - firstOBIndex)];
                                  }
                              }];
    [alertView show];
}

#pragma mark - 全屏
-(void)fullScreenButtonTapped
{
    self.isFullScreen = self.view.fullscreenButton.selected;

    if (self.isFullScreen) {
        [self performOrientationChange:UIInterfaceOrientationLandscapeRight];
    } else {
        [self performOrientationChange:UIInterfaceOrientationPortrait];
    }

    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventTapFullScreen];
    }
}
//#pragma mark - 选集
//-(void)selectMenuButtonTapped
//{
//#warning TODO -
//}
//#pragma mark - 选集
//-(void)selectMenuButtonTapped
//{
//#warning TODO -
//}
//#pragma mark - 选集
//-(void)selectMenuButtonTapped
//{
//#warning TODO -
//}


- (void)performOrientationChange:(UIInterfaceOrientation)deviceOrientation {
    if (!self.forceRotate) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(videoPlayer:willChangeOrientationTo:)]) {
        [self.delegate videoPlayer:self willChangeOrientationTo:deviceOrientation];
    }

    CGFloat degrees = [self degreesForOrientation:deviceOrientation];
    __weak __typeof__(self) weakSelf = self;
    UIInterfaceOrientation lastOrientation = self.visibleInterfaceOrientation;
    self.visibleInterfaceOrientation = deviceOrientation;
    [UIView animateWithDuration:0.3f animations:^{
        CGRect bounds = [[UIScreen mainScreen] bounds];
        CGRect parentBounds;
        CGRect viewBoutnds;
        if (UIInterfaceOrientationIsLandscape(deviceOrientation)) {
            viewBoutnds = CGRectMake(0, 0, CGRectGetWidth(self.landscapeFrame), CGRectGetHeight(self.landscapeFrame));
            parentBounds = CGRectMake(0, 0, CGRectGetHeight(bounds), CGRectGetWidth(bounds));
        } else {
            viewBoutnds = CGRectMake(0, 0, CGRectGetWidth(self.portraitFrame), CGRectGetHeight(self.portraitFrame));
            parentBounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds));
        }

        weakSelf.view.superview.transform = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        weakSelf.view.superview.bounds = parentBounds;
        [weakSelf.view.superview setFrameOriginX:0.0f];
        [weakSelf.view.superview setFrameOriginY:0.0f];

        CGRect wvFrame = weakSelf.view.superview.superview.frame;
        if (wvFrame.origin.y > 0) {
            wvFrame.size.height = CGRectGetHeight(bounds) ;
            wvFrame.origin.y = 0;
            weakSelf.view.superview.superview.frame = wvFrame;
        }

        weakSelf.view.bounds = viewBoutnds;
        [weakSelf.view setFrameOriginX:0.0f];
        [weakSelf.view setFrameOriginY:0.0f];
        [weakSelf.view layoutForOrientation:deviceOrientation];

    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(videoPlayer:didChangeOrientationFrom:)]) {
            [self.delegate videoPlayer:self didChangeOrientationFrom:lastOrientation];
        }
    }];

    [[UIApplication sharedApplication] setStatusBarOrientation:self.visibleInterfaceOrientation animated:YES];
//    [self updateCaptionView:self.view.captionBottomView caption:self.captionBottom playerView:self.view];
//    [self updateCaptionView:self.view.captionTopView caption:self.captionTop playerView:self.view];
    self.view.fullscreenButton.selected = self.isFullScreen = UIInterfaceOrientationIsLandscape(deviceOrientation);
}

- (CGFloat)degreesForOrientation:(UIInterfaceOrientation)deviceOrientation {
    switch (deviceOrientation) {
        case UIInterfaceOrientationPortrait:
            return 0;
            break;
        case UIInterfaceOrientationLandscapeRight:
            return 90;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return -90;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return 180;
            break;
    }
    return 0;
}

#pragma mark - 切换model
-(void)switchVideoViewModeButtonAction
{
    static emVMVideoFillMode modes[] = {
        VMVideoFillModeFit,
        VMVideoFillMode100,
        VMVideoFillModeCrop,
        VMVideoFillModeStretch,
    };
    static int curModeIdx = 0;

    curModeIdx = (curModeIdx + 1) % (int)(sizeof(modes)/sizeof(modes[0]));
    [self.mMPayer setVideoFillMode:modes[curModeIdx]];
}

#pragma mark - VMediaPlayerDelegate Implement

#pragma mark VMediaPlayerDelegate Implement / Required

- (void)mediaPlayer:(VMediaPlayer *)player didPrepared:(id)arg
{
    //	[player setVideoFillMode:VMVideoFillMode100];
    [player setVideoFillMode:VMVideoFillModeFit];//可以撑满屏幕 VMVideoFillModeCrop
    
    mDuration = [player getDuration];
    NSLog(@"------- mDuration：%ld",mDuration);

#pragma mark - 定位到指定的时间播放
    if (self.lastWatchPos > 0) {
        [player seekTo:self.lastWatchPos];
        self.view.curPosLbl.text = [TFUtilities timeToHumanString:self.lastWatchPos];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [player start];
//        });
    }

    [player start];

    [self.view setBtnEnableStatus:YES];
    [self.view stopActivity];
    mSyncSeekTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/3
                                                      target:self
                                                    selector:@selector(syncUIStatus)
                                                    userInfo:nil
                                                     repeats:YES];
    
    //设置音轨
    NSArray * arr = [self.mMPayer getAudioTracksArray];
    self.view.trackBtn.hidden = YES;
    if (arr.count <= 1) return;
    
    self.view.trackBtn.hidden = NO;
    self.trackArray = [NSMutableArray array];
    //    {
    //        VMMediaTrackId = 1;
    //        VMMediaTrackLocationType = 0;
    //        VMMediaTrackTitle = "1. und. SoundHandler";
    //    }
    for (NSDictionary *dic in arr) {
        [self.trackArray addObject:dic[@"VMMediaTrackTitle"]];
    }
    //    [mMPayer setAudioTrackWithArrayIndex:1];
    //    int index  = [mMPayer getAudioTrackCurrentArrayIndex];
    //    NSLog(@"index:%d-:%lu-%@",index,(unsigned long)arr.count,arr);
    //    NSLog(@"VMMediaTrackTitle:%@,",arr[1][@"VMMediaTrackTitle"]);

}

- (void)mediaPlayer:(VMediaPlayer *)player playbackComplete:(id)arg
{
//    [self doneButtonTapped];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventTapDone];
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player error:(id)arg
{
    NSLog(@"NAL 1RRE &&&& VMediaPlayer Error: %@", arg);
    [self.view stopActivity];
//    //	[self showVideoLoadingError];
    [self.view setBtnEnableStatus:YES];

}

#pragma mark VMediaPlayerDelegate Implement / Optional

- (void)mediaPlayer:(VMediaPlayer *)player setupManagerPreference:(id)arg
{
    player.decodingSchemeHint = VMDecodingSchemeSoftware;
    player.autoSwitchDecodingScheme = YES;
}

- (void)mediaPlayer:(VMediaPlayer *)player setupPlayerPreference:(id)arg
{
    // Set buffer size, default is 1024KB(1*1024*1024).
    //	[player setBufferSize:256*1024];
    [player setBufferSize:512*1024];
    [player setAdaptiveStream:YES];

    [player setVideoQuality:VMVideoQualityHigh];
    
    player.useCache = YES;
    [player setCacheDirectory:[self getCacheRootDirectory]];
}
- (NSString *)getCacheRootDirectory
{
    NSString *cache = [NSString stringWithFormat:@"%@/Library/Caches/MediasCaches", NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cache]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    return cache;
}
- (void)mediaPlayer:(VMediaPlayer *)player seekComplete:(id)arg
{
    BOOL result = player.isPlaying;
    NSLog(@"--seekComplete-:%d",player.isPlaying);
    [self.view stopActivity];

}

- (void)mediaPlayer:(VMediaPlayer *)player notSeekable:(id)arg
{
    self.progressDragging = NO;
    NSLog(@"NAL 1HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingStart:(id)arg
{
    self.progressDragging = YES;
    NSLog(@"NAL 2HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
    if (![TFUtilities isLocalMedia:self.videoURL]) {
        [player pause];
//        [self.view.startPause setImage:KTFPlayer_Btn_Play forState:UIControlStateNormal];
        self.view.startPause.selected = YES;
        self.view.bigPlayButton.selected = YES;
        [self.view startActivityWithMsg:@"Buffering... 0%"];
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingUpdate:(id)arg
{
    if (!self.view.bubbleMsgLbl.hidden) {
        self.view.bubbleMsgLbl.text = [NSString stringWithFormat:@"缓冲... %d%%",
                                  [((NSNumber *)arg) intValue]];
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingEnd:(id)arg
{
    if (![TFUtilities isLocalMedia:self.videoURL]) {
        [player start];
//        [self.view.startPause setImage:KTFPlayer_Btn_pause forState:UIControlStateNormal];
        self.view.startPause.selected = NO;
        self.view.bigPlayButton.selected = NO;
        [self.view stopActivity];
    }
    self.progressDragging = NO;
    NSLog(@"NAL 3HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
}

- (void)mediaPlayer:(VMediaPlayer *)player downloadRate:(id)arg
{
    if (![TFUtilities isLocalMedia:self.videoURL]) {
//        if(!self.mMPayer.isPlaying){
            self.view.downloadRate.text = [NSString stringWithFormat:@"%dKB/s", [arg intValue]];
//        }
    } else {
        self.view.downloadRate.text = nil;
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player videoTrackLagging:(id)arg
{
    //	NSLog(@"NAL 1BGR video lagging....");
}

- (void)mediaPlayer:(VMediaPlayer *)player info:(id)arg
{
    NSLog(@"info:%@",arg);
}

#pragma mark VMediaPlayerDelegate Implement / Cache

- (void)mediaPlayer:(VMediaPlayer *)player cacheNotAvailable:(id)arg
{
    NSLog(@"NAL .... media can't cache.");
    self.view.progressSld.segments = nil;
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheStart:(id)arg
{
    NSLog(@"NAL 1GFC .... media caches index : %@", arg);
}

#pragma mark - mark 更新进度条的缓冲
- (void)mediaPlayer:(VMediaPlayer *)player cacheUpdate:(id)arg
{
    NSArray *segs = (NSArray *)arg;
    //	NSLog(@"NAL .... media cacheUpdate, %d, %@", segs.count, segs);
    if (mDuration > 0) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < segs.count; i++) {
            float val = (float)[segs[i] longLongValue] / mDuration;
            [arr addObject:[NSNumber numberWithFloat:val]];
        }
        self.view.progressSld.segments = arr;
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheSpeed:(id)arg
{
    //	NSLog(@"NAL .... media cacheSpeed: %dKB/s", [(NSNumber *)arg intValue]);
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheComplete:(id)arg
{
    NSLog(@"NAL .... media cacheComplete");
    self.view.progressSld.segments = @[@(0.0), @(1.0)];
}

 
#pragma mark - Convention Methods


-(void)quicklyPlayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //	[self setBtnEnableStatus:NO];
    
    NSString *docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    NSLog(@"NAL &&& Doc: %@", docDir);

     NSString *abs = [fileURL absoluteString];
    if ([abs rangeOfString:@"://"].length == 0) {
        NSString *docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
        NSString *videoUrl = [NSString stringWithFormat:@"%@/%@", docDir, abs];
        self.videoURL = [NSURL fileURLWithPath:videoUrl];
    } else {
        self.videoURL = fileURL;
    }
    //    [mMPayer setDataSource:self.videoURL header:nil];
    [self.mMPayer setDataSource:self.videoURL header:nil];

    self.view.titleLabel.text = title;

    if (pos > 5)  pos -= 5;//时间自动向前5秒，提升用户体验
    self.lastWatchPos = pos*1000;//lastWatchPos：秒，pos：毫秒   -- 1秒=1000毫秒
    [self.mMPayer prepareAsync];
    [self.view startActivityWithMsg:@"Loading..."];
}

-(void)quicklyReplayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos
{
    [self quicklyStopMovie];
    [self quicklyPlayMovie:fileURL title:title seekToPos:pos];
}

-(void)quicklyStopMovie
{
    [self.mMPayer reset];
    [mSyncSeekTimer invalidate];
    mSyncSeekTimer = nil;
    self.view.progressSld.value = 0.0;
    self.view.progressSld.segments = nil;
    self.view.curPosLbl.text = @"00:00:00";
    self.view.durationLbl.text = @"00:00:00";
    self.view.downloadRate.text = nil;
    mDuration = 0;
    mCurPostion = 0;
    [self.view stopActivity];
    [self.view setBtnEnableStatus:YES];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    self.lastWatchPos = 0;
}

#pragma mark - Sync UI Status

-(void)syncUIStatus
{
    if (!self.progressDragging) {
        mCurPostion  = [self.mMPayer getCurrentPosition];
        [self.view.progressSld setValue:(float)mCurPostion/mDuration];
        self.view.curPosLbl.text = [TFUtilities timeToHumanString:mCurPostion];
        //        NSLog(@"---syncUIStatus---:%@",[TFUtilities timeToHumanString:mCurPostion]);
        self.view.durationLbl.text = [NSString stringWithFormat:@"/%@",[TFUtilities timeToHumanString:mDuration]];
    }
}

- (void)unSetupObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)dealloc {
    [self unInstallPlayer];
    
    
    //    [self.rewindButton removeObserver:self forKeyPath:@"hidden"];
    //    [self.nextButton removeObserver:self forKeyPath:@"hidden"];
    
    //    [self removeObservers];
    //
    //    [self.externalMonitor deactivate];
    //
    //    self.timeObserver = nil;
    //    self.avPlayer = nil;
    //    self.captionTop = nil;
    //    self.captionBottom = nil;
    //    self.captionTopTimer = nil;
    //    self.captionBottomTimer = nil;
    //
    //    self.playerItem = nil;
    //
    //    [self pauseContent];
}

-(void)unInstallPlayer
{
    [self quicklyStopMovie];

    [self unSetupObservers];
    [_mMPayer unSetupPlayer];

    BOOL b = [_mMPayer unSetupPlayer];
    NSLog(@"%d",b);
    _mMPayer = nil;
//    TFVideoPlayer = nil;
    NSLog(@"------:");
//    [self.view.progressSld removeObserver:self forKeyPath:@"maximumValue"];
}


-(void)playerWillAppear
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self.view becomeFirstResponder];

//    [self currButtonAction:nil];
}

-(void)playerDidDisAppear
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self.view resignFirstResponder];
}



@end
