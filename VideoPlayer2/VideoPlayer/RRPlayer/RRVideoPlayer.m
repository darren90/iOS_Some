//
//  RRVideoPlayer.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RRVideoPlayer.h"

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


@interface RRVideoPlayer ()<RRVideoPlayerViewDelegate>
{
    long               mDuration;
    long               mCurPostion;
    NSTimer            *mSyncSeekTimer;
    
    BOOL isEndFast;//快进结束
    NSNumber * fastNum;
}

@property (nonatomic, assign) BOOL progressDragging;

@end

@implementation RRVideoPlayer

//异步线程更改
void RUN_ON_UI_THREAD(dispatch_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

static   RRVideoPlayer *rrVideoPlayer = nil;

+(RRVideoPlayer *) sharedPlayer
{
    @synchronized(self){
        if (rrVideoPlayer == nil) {
            rrVideoPlayer = [[self alloc] init];
        }
    }
    return  rrVideoPlayer;
}

- (id)init {
    self = [super init];
    if (self) {
        self.view = [RRVideoPlayerView videoPlayerView];
        [self initialize];
    }
    return self;
}

//-(void)setIsPlayLocalFile:(BOOL)isPlayLocalFile
//{
//    _isPlayLocalFile = isPlayLocalFile;
//    self.view.isPlayLocalFile = isPlayLocalFile;
//}

- (id)initWithVideoPlayerView:(RRVideoPlayerView*)videoPlayerView {
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

    if (!self.mMPayer) {
        self.mMPayer = [VMediaPlayer sharedInstance];
        [self.mMPayer setupPlayerWithCarrierView:self.view.carrier withDelegate:self];
        [self setupObservers];
    }
}



-(void)playStreamUrl:(NSURL*)url
{
    NSLog(@"---playStreamUrl---");
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        long lastPos = 0;
        [weakSelf quicklyPlayMovie:url title:@"stest水电费水电费是电风扇的" seekToPos:lastPos];
    });
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
        [self.mMPayer setVideoShown:YES];
        [self.mMPayer start];

        WS(weakSelf);
        RUN_ON_UI_THREAD(^{
            [weakSelf.view.startPause setImage:KTFPlayer_Btn_pause forState:UIControlStateNormal];
        });
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    if ([self.mMPayer isPlaying]) {
        [self.mMPayer pause];
        [self.mMPayer setVideoShown:NO];
    }
}



///

#pragma mark - RRVideoPlayerViewDelegate
- (void)captionButtonTapped {
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventTapCaption];
    }
}

- (void)playButtonPressed {
    [self playContent];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventPlay];
    }
}

- (void)pauseButtonPressed {
    [self pauseContent];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventPause];
    }
}

-(void)progressSliderUp:(float)value
{
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:(long)(value * mDuration)];
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
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:seek];
}

-(void)endFastWithTime:(long)time
{
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:time];
}

- (void)playContent {
    WS(weakSelf);
    RUN_ON_UI_THREAD(^{
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
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventTapDone];
    }
}

#pragma mark - 分享
-(void)shareButtonTapped
{
#warning TODO - 
}

#pragma mark - 选集
-(void)selectMenuButtonTapped
{
#warning TODO -
}


#pragma mark - 弹幕按钮
-(void)isAllowDanmu
{
#warning TODO -
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
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventTapFullScreen];
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
    [player start];
    
//    [self setBtnEnableStatus:YES];
//    [self stopActivity];
    mSyncSeekTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/3
                                                      target:self
                                                    selector:@selector(syncUIStatus)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)mediaPlayer:(VMediaPlayer *)player playbackComplete:(id)arg
{
//    [self doneButtonTapped];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventTapDone];
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player error:(id)arg
{
    NSLog(@"NAL 1RRE &&&& VMediaPlayer Error: %@", arg);
//    [self stopActivity];
//    //	[self showVideoLoadingError];
//    [self setBtnEnableStatus:YES];
 
    NSLog(@"error:%@",arg);
}

#pragma mark VMediaPlayerDelegate Implement / Optional

- (void)mediaPlayer:(VMediaPlayer *)player setupManagerPreference:(id)arg
{
    player.decodingSchemeHint = VMDecodingSchemeSoftware;
    player.autoSwitchDecodingScheme = NO;
}

- (void)mediaPlayer:(VMediaPlayer *)player setupPlayerPreference:(id)arg
{
    // Set buffer size, default is 1024KB(1*1024*1024).
    //	[player setBufferSize:256*1024];
    [player setBufferSize:512*1024];
    //	[player setAdaptiveStream:YES];
    
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
        self.view.bubbleMsgLbl.text = [NSString stringWithFormat:@"缓冲中... %d%%",
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
        if(!self.mMPayer.isPlaying){
            self.view.downloadRate.text = [NSString stringWithFormat:@"%dKB/s", [arg intValue]];
        }
    } else {
        self.view.downloadRate.text = nil;
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player videoTrackLagging:(id)arg
{
    //	NSLog(@"NAL 1BGR video lagging....");
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
    [self.mMPayer setDataSource:self.videoURL];

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
//    [self setBtnEnableStatus:YES];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

//-(void)startActivityWithMsg:(NSString *)msg
//{
//    self.view.bubbleMsgLbl.hidden = NO;
//    self.view.bubbleMsgLbl.text = msg;
//    [self.view.activityView startAnimating];
//}
//
//-(void)stopActivity
//{
//    self.view.bubbleMsgLbl.hidden = YES;
//    self.view.bubbleMsgLbl.text = nil;
//    [self.view.activityView stopAnimating];
//}


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
//    rrVideoPlayer = nil;
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
