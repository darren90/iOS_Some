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


@interface TFVideoPlayer ()<TFVideoPlayerViewDelegate,UIAlertViewDelegate>
{
    long               mDuration;
    long               mCurPostion;
    NSTimer            *mSyncSeekTimer;
    
    BOOL isEndFast;//快进结束
    NSNumber * fastNum;
}

@property (nonatomic, copy)   NSURL *videoURL;

@property (nonatomic, assign) BOOL progressDragging;

/** 上一次的观看时间 单位：秒 */
@property (nonatomic,assign)long lastWatchPos;


//音轨的数组
@property (nonatomic,strong)NSMutableArray * trackArray;

/** 是否在进入后台前是播放的播放 */
@property (nonatomic,assign)BOOL isBeforePlaying;

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
        [self.mMPayer setSubShown:YES];
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
//    __weak __typeof(self)weakSelf = self;
    [self quicklyPlayMovie:url title:title seekToPos:pos];
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
        if (self.isBeforePlaying) {
            self.isBeforePlaying = NO;
            [self.mMPayer start];//视频不再自动播放
            [self.view setPlayButtonsSelected:NO];
        }
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    if ([self.mMPayer isPlaying]) {
        [self.mMPayer pause];
        [self.view setPlayButtonsSelected:YES];//设置按钮的状态
        self.isBeforePlaying = YES;
    }
}


#pragma mark - TFVideoPlayerViewDelegate
- (void)captionButtonTapped {
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventTapCaption];
    }
}

- (void)playButtonPressed {
//    [self playContent];
    [self.mMPayer start];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventPlay];
    }
}

- (void)pauseButtonPressed {
//    [self pauseContent];
    [self.mMPayer pause];
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
    return [self.mMPayer getCurrentPosition];//mCurPostion;
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
    [self moveProgressWithTime:seek];
}

-(void)endFastWithTime:(long)time
{
    [self moveProgressWithTime:time];
}

-(void)moveProgressWithTime:(long)time
{
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:time];

//    if (!self.mMPayer.isPlaying) {//没有播放的时候，拖动进度条后，进行播放
//        [self.mMPayer start];
//    }
    [self playContent];
}

- (void)playContent {
    if (!self.mMPayer.isPlaying) {
        [self.mMPayer start];
        [self.view setPlayButtonsSelected:NO];//设置按钮的状态
    }
}

- (void)pauseContent {
    if (self.mMPayer.isPlaying) {
        [self.mMPayer pause];
        [self.view setPlayButtonsSelected:YES];//设置按钮的状态
    }
}


-(void)doneButtonTapped
{
//    [self quicklyStopMovie];
//
//    [self unSetupObservers];
//    //    [mMPayer unSetupPlayer];
//    BOOL b = [_mMPayer unSetupPlayer];
//    NSLog(@"%d",b);

    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventTapDone];
    }
}

#pragma mark --------分割线-----------------
#pragma mark - 分享
-(void)shareButtonTapped
{
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        [self.delegate videoPlayer:self didControlByEvent:TFVideoPlayerControlEventShare];
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
    if (self.trackArray.count == 0)  return;
    
//    UIAlertView *alertView = [UIAlertView
//                          showWithTitle:@"Audio Trackers Picker"
//                          message:nil
//                          cancelButtonTitle:@"Cancel"
//                          otherButtonTitles:self.trackArray
//                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//                              NSInteger firstOBIndex = [alertView firstOtherButtonIndex];
//                              NSInteger lastOBIndex = firstOBIndex + [self.trackArray count];
//                              if (buttonIndex >= firstOBIndex && buttonIndex < lastOBIndex) {
//                                  [self.mMPayer setAudioTrackWithArrayIndex:(int)(buttonIndex - firstOBIndex)];
//                              }
//                          }];
//    [alertView show];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请选中音轨" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    for (NSString *title in self.trackArray){
        [alert addButtonWithTitle:title];
    }
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    int selectIndex = (int)buttonIndex - 1;
    if (selectIndex >= 0 && selectIndex < self.trackArray.count) {
        [self.mMPayer setAudioTrackWithArrayIndex:selectIndex];
    }
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
    
    //设置字幕
    [self.mMPayer setSubShown:YES];
//    [self.mMPayer setSubEncoding:@"UTF-8"];//latin1
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSString *pp = [docsDir stringByAppendingPathComponent:@"love01.srt"];
    NSString *text = [NSString stringWithContentsOfFile:pp encoding:NSUnicodeStringEncoding error:nil];
    NSLog(@"--text:%@",text);
    BOOL result = [self.mMPayer addSubTrackToArrayWithPath:pp];
//    [self.mMPayer setSubTrackWithPath:pp];
    NSLog(@"--:%d",result);
    
    NSArray *a = [self.mMPayer getSubTracksArray];
//    BOOL rr = [self.mMPayer setSubTrackWithArrayIndex:0];
//    int index = [self.mMPayer getSubTrackCurrentArrayIndex];
    NSString *cur = [self.mMPayer getCurSubText];
    NSLog(@"--subArray:%@-:%@",a,cur );
    [self.mMPayer setSubShown:YES];
    [self.mMPayer setSubEncoding:@"Unicode"];

    
    mDuration = [player getDuration];
    self.totalDuraion = mDuration / 1000.000 ;

#pragma mark - 定位到指定的时间播放
    if (self.lastWatchPos > 0) {
        [player seekTo:self.lastWatchPos];
        self.view.curPosLbl.text = [TFUtilities timeToHumanString:self.lastWatchPos];
    }

    [player start];
    [self.view setPlayButtonsSelected:NO];//设置按钮的状态

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
    [player setBufferSize:512*1024*1024];
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
    self.progressDragging = NO;
    [self.view stopActivity];
}

- (void)mediaPlayer:(VMediaPlayer *)player notSeekable:(id)arg
{
    self.progressDragging = NO;
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingStart:(id)arg
{
    if (self.isPlayLocalFile) return;
    self.progressDragging = YES;

    if (![TFUtilities isLocalMedia:self.videoURL]) {
        [player pause];
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
    if (self.isPlayLocalFile) return;
    if (![TFUtilities isLocalMedia:self.videoURL]) {
        [player start];
        [self.view stopActivity];
    }
    self.progressDragging = NO;
}

- (void)mediaPlayer:(VMediaPlayer *)player downloadRate:(id)arg
{
    if (![TFUtilities isLocalMedia:self.videoURL]) {
            self.view.downloadRate.text = [NSString stringWithFormat:@"%dKB/s", [arg intValue]];
    } else {
        self.view.downloadRate.text = nil;
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player videoTrackLagging:(id)arg
{
    //	NSLog(@"NAL 1BGR video lagging....") ;
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
    
    [self.mMPayer setSubShown:YES];
    [self.mMPayer setSubEncoding:@"UTF-8"];

    //设置字幕
//    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
//    NSString *pp = [docsDir stringByAppendingPathComponent:@"Agents.ass"];
//    NSString *text = [NSString stringWithContentsOfFile:pp encoding:NSISOLatin2StringEncoding error:nil];
////    NSLog(@"--text:%@",text);
//    BOOL result = [self.mMPayer addSubTrackToArrayWithPath:pp];
//    [self.mMPayer setSubTrackWithPath:docsDir];
//    NSLog(@"--:%d",result);
//    
//    NSArray *a = [self.mMPayer getSubTracksArray];
//    NSLog(@"--subArray:%@",a );
    
    //
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
    [self.mMPayer setSubShown:YES];
}


-(double)currentDuraion
{
    double result = 0.000;
    result = [self.mMPayer getCurrentPosition] / 1000.000;
    return result ;}

#pragma mark - Sync UI Status

-(void)syncUIStatus
{
    if (!self.progressDragging) {
        mCurPostion  = [self.mMPayer getCurrentPosition];
        [self.view.progressSld setValue:(float)mCurPostion/mDuration];
        self.view.curPosLbl.text = [TFUtilities timeToHumanString:mCurPostion];
        self.view.durationLbl.text = [NSString stringWithFormat:@"/%@",[TFUtilities timeToHumanString:mDuration]];
    }
}

- (void)dealloc {
    [self unInstallPlayer];
    NSLog(@"---TFVideoPlayer--销毁了");
}

- (void)unSetupObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)unInstallPlayer
{
    [mSyncSeekTimer invalidate];
    mSyncSeekTimer = nil;
    [self quicklyStopMovie];

    [self unSetupObservers];
    [_mMPayer unSetupPlayer];

    _mMPayer = nil;
    [_view unInstallPlayerView];
    [_view removeFromSuperview];
    [_view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


-(void)playerWillAppear
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self.view becomeFirstResponder];
}

-(void)playerDidDisAppear
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self.view resignFirstResponder];
}



@end
