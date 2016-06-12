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

#define KTFPlayer_Btn_Play [UIImage imageNamed:@"VKVideoPlayer_play.png"]
#define KTFPlayer_Btn_pause [UIImage imageNamed:@"VKVideoPlayer_pause.png"]



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



-(void)playStreamUrl:(NSURL*)url
{
    long lastPos = 0;
    [self quicklyPlayMovie:url title:@"stest水电费水电费是电风扇的" seekToPos:lastPos];
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



//-(void)

- (void)setupObservers
{
    NSNotificationCenter *def = [NSNotificationCenter defaultCenter];
    [def addObserver:self
            selector:@selector(applicationDidEnterForeground:)
                name:UIApplicationDidBecomeActiveNotification
              object:[UIApplication sharedApplication]];
    [def addObserver:self
            selector:@selector(applicationDidEnterBackground:)
                name:UIApplicationWillResignActiveNotification
              object:[UIApplication sharedApplication]];
}

- (void)applicationDidEnterForeground:(NSNotification *)notification
{
    [self.mMPayer setVideoShown:YES];
    if (![self.mMPayer isPlaying]) {
        [self.mMPayer start];

        RUN_ON_UI_THREAD(^{
            [self.view.startPause setImage:KTFPlayer_Btn_pause forState:UIControlStateNormal];
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
        NSLog(@"%s",__func__);
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventTapCaption];
    }
}

- (void)playButtonPressed {
    [self playContent];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
        NSLog(@"%s",__func__);

        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventPlay];
    }
}

- (void)pauseButtonPressed {
    [self pauseContent];
    if ([self.delegate respondsToSelector:@selector(videoPlayer:didControlByEvent:)]) {
         NSLog(@"%s",__func__);
        [self.delegate videoPlayer:self didControlByEvent:VKVideoPlayerControlEventPause];
    }
}

-(void)progressSliderUp:(float)value
{
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:(long)(value * mDuration)];
}

-(long)getDuration
{
//    mDuration = [self.mMPayer getDuration];
    return mDuration;
}

-(void)progressSliderTapped:(CGFloat)percentage
{
    long seek = percentage * mDuration;
//    self.curPosLbl.text = [TFUtilities timeToHumanString:seek];
    NSLog(@"NAL 2BVC &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& seek = %ld", seek);
    [self.view startActivityWithMsg:@"Buffering"];
    [self.mMPayer seekTo:seek];
}

- (void)playContent {
    RUN_ON_UI_THREAD(^{
        [self.mMPayer start];
    });
}

- (void)pauseContent {
//    [self pauseContent:NO completionHandler:nil];
    [self.mMPayer pause];
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
//    [self goBackButtonAction:nil];
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
//    if (![TFUtilities isLocalMedia:self.videoURL]) {
//        [player pause];
//        //		[self.startPause setTitle:@"Start" forState:UIControlStateNormal];
//        [self.startPause setImage:KTFPlayer_Btn_Play forState:UIControlStateNormal];
//        [self startActivityWithMsg:@"Buffering... 0%"];
//    }
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingUpdate:(id)arg
{
//    if (!self.bubbleMsgLbl.hidden) {
//        self.bubbleMsgLbl.text = [NSString stringWithFormat:@"Buffering... %d%%",
//                                  [((NSNumber *)arg) intValue]];
//    }
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingEnd:(id)arg
{
    if (![TFUtilities isLocalMedia:self.videoURL]) {
        [player start];
        //		[self.startPause setTitle:@"Pause" forState:UIControlStateNormal];
//        [self.view.startPause setImage:KTFPlayer_Btn_pause forState:UIControlStateNormal];
        [self pauseContent];
//        [self stopActivity];
    }
    self.progressDragging = NO;
    NSLog(@"NAL 3HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
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


//-(void)setVideoURL:(NSURL *)videoURL
//{
//    _videoURL = [videoURL copy];
//    long lastPos = 0;
//
//    [self quicklyPlayMovie:_videoURL title:@"stest水电费水电费是电风扇的" seekToPos:lastPos];
//}

#pragma mark - Convention Methods

#define TEST_Common					1
#define TEST_setOptionsWithKeys		0
#define TEST_setDataSegmentsSource	0

-(void)quicklyPlayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //	[self setBtnEnableStatus:NO];
    
    NSString *docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    NSLog(@"NAL &&& Doc: %@", docDir);

#if TEST_Common // Test Common
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
#elif TEST_setOptionsWithKeys // Test setOptionsWithKeys:withValues:
    self.videoURL = [NSURL URLWithString:@"rtmp://videodownls.9xiu.com/9xiu/552"]; // This is a live stream.
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *vals = [NSMutableArray arrayWithCapacity:0];
    keys[0] = @"-rtmp_live";
    vals[0] = @"-1";
    [mMPayer setDataSource:self.videoURL header:nil];
    [mMPayer setOptionsWithKeys:keys withValues:vals];
#elif TEST_setDataSegmentsSource // Test setDataSegmentsSource:fileList:
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.1.mp4?vkey=E3D97333E93EDF36E56CB85CE0B02018E1001BA5C023DFFD298C0204CD81610CFCE546C79DE6C3E2"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.2.mp4?vkey=5E82F44940C19CCF26610E7E4088438E868AB2CAB5255E5FDE6763484B9B7E967EF9A97D7E54A324"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.3.mp4?vkey=0A1EA30BCB057BAE8746C2D7B07FE4ABF3BD839FF011224F31F7544BFFB647F06A6D5245C57277BC"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.4.mp4?vkey=DF36DC29AD2C2F0BA5A688223AFCD0008BDD681D8B060C9F4739E1A365495CD165E28DFD80E8E41C"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.5.mp4?vkey=76172D18B89A91CDB803889B4C5127741EF4BBD9B90CC54269B89CEEF558B9B286DDE6083ADB8195"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.6.mp4?vkey=27718B68A396DCFBC483321827604179D35F31C41EC57908C0F78D9416690F6986B0766872C2AF60"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.7.mp4?vkey=B56628DD31A60E975CC9EE321DCE2FC9554AF2CE5BC2BFCEFCEEA633F27CDF16CADA9915338AB2E5"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.8.mp4?vkey=40F45871CE7827699FACE57A95CA1FDA58B16A8A2523C738C422ADCBF015F50254C356614EFAFDE0"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.9.mp4?vkey=553157FD5A7607CC1E255D0E26B503FAD842DC509F15D766C31446E8607E60A621F7B9FABC5B8C7D"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.10.mp4?vkey=2968D15E93D1C1A295FC810DA561789487330F8BEA5B408533BF396648400A89924611724FD5BE67"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.11.mp4?vkey=495CDFCAD30945947CE1E43CBD88DE32E505B4D02BD4AAB2F4B17F98EFF702485C270558951A3109"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.12.mp4?vkey=01B5580A0A6F3597D66440C060885AFC7AA03CD7272D36472FBC9C261D72D2E964D254775C574CA3"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.13.mp4?vkey=2256FFE5FABC971F6A0D6889A1EA1CE8E837D17929708C6ACC6F903939076BB926442DBF6F3AD309"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.14.mp4?vkey=77BB2C40B9383BF048206EC357FE5F061A0A16B9242CAD207CBEA3C3C53E50B24056D93E578A400F"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.15.mp4?vkey=1366F026BB6B987C82C58CF707269C091EA086BB1A09430611A6E124A419E04774FE793E11EB64C1"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.16.mp4?vkey=E0F358E64365C5B12614EA74B25C4F87C7E8CD4003DCB2C792850180CF3CD7645BB22E5E57B40CC5"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.17.mp4?vkey=E95EC62FAE0D92BE8A2FE85842B875F2E9B9B07616B8892D1EF18A0C645994E885D65BDAC24EF0FD"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.18.mp4?vkey=48B021C886CFC23E22FA56C71C7C204E300E7D58CBB97867F23CC8F30EB4D1B53ABE41627F7D6610"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.19.mp4?vkey=0D51F428BB12C2C5C015E41997371FC80338924F804D9D688C7B9560C7336A48870873F34189C58D"];
    [mMPayer setDataSegmentsSource:nil fileList:list];
#endif
    
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
        self.view.durationLbl.text = [TFUtilities timeToHumanString:mDuration];
    }
}


- (void)unSetupObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)dealloc {
    [self pauseContent];
    
    [self unSetupObservers];
    [self.mMPayer unSetupPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view.progressSld removeObserver:self forKeyPath:@"maximumValue"];
    
    
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


@end
