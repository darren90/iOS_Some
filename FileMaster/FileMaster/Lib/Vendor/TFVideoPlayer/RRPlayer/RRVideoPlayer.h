//
//  RRVideoPlayer.h
//  VideoPlayer
//
//  Created by Fengtf on 16/6/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRVideoPlayerView.h"
#import "Vitamio.h"


typedef enum {
    // The video was flagged as blocked due to licensing restrictions (geo or device).
    kVideoPlayerErrorVideoBlocked = 900,
    
    // There was an error fetching the stream.
    kVideoPlayerErrorFetchStreamError,
    
    // Could not find the stream type for video.
    kVideoPlayerErrorStreamNotFound,
    
    // There was an error loading the video as an asset.
    kVideoPlayerErrorAssetLoadError,
    
    // There was an error loading the video's duration.
    kVideoPlayerErrorDurationLoadError,
    
    // AVPlayer failed to load the asset.
    kVideoPlayerErrorAVPlayerFail,
    
    // AVPlayerItem failed to load the asset.
    kVideoPlayerErrorAVPlayerItemFail,
    
    // Chromecast failed to load the stream.
    kVideoPlayerErrorChromecastLoadFail,
    
    // There was an unknown error.
    kVideoPlayerErrorUnknown,
    
} RRVideoPlayerErrorCode;


typedef enum {
    RRVideoPlayerStateUnknown,
    RRVideoPlayerStateContentLoading,
    RRVideoPlayerStateContentPlaying,
    RRVideoPlayerStateContentPaused,
    RRVideoPlayerStateSuspend,
    RRVideoPlayerStateDismissed,
    RRVideoPlayerStateError
} RRVideoPlayerState;

typedef enum {
    RRVideoPlayerControlEventTapPlayerView,
    RRVideoPlayerControlEventTapNext,
    RRVideoPlayerControlEventTapPrevious,
    RRVideoPlayerControlEventTapDone,
    RRVideoPlayerControlEventTapFullScreen,
    RRVideoPlayerControlEventTapCaption,
    RRVideoPlayerControlEventTapVideoQuality,
    RRVideoPlayerControlEventSwipeNext,
    RRVideoPlayerControlEventSwipePrevious,
    RRVideoPlayerControlEventShare,//分享
    RRVideoPlayerControlEventSuggest,//反馈
    RRVideoPlayerControlEventSelectMenu,//选集
    RRVideoPlayerControlEventPause,//暂停
    RRVideoPlayerControlEventPlay,//播放
    RRVideoplayercontroleventDanMu,//弹幕
    RRVideoplayercontroleventClarity,//清晰度
} RRVideoPlayerControlEvent;


@class RRVideoPlayer;
@protocol RRVideoPlayerDelegate <NSObject>
@optional
- (BOOL)shouldVideoPlayer:(RRVideoPlayer*)videoPlayer changeStateTo:(RRVideoPlayerState)toState;
- (void)videoPlayer:(RRVideoPlayer*)videoPlayer willChangeStateTo:(RRVideoPlayerState)toState;
- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didChangeStateFrom:(RRVideoPlayerState)fromState;
//- (BOOL)shouldVideoPlayer:(RRVideoPlayer*)videoPlayer startVideo:(id<RRVideoPlayerTrackProtocol>)track;
//- (void)videoPlayer:(RRVideoPlayer*)videoPlayer willStartVideo:(id<RRVideoPlayerTrackProtocol>)track;
//- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didStartVideo:(id<RRVideoPlayerTrackProtocol>)track;
//
//- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didPlayFrame:(id<RRVideoPlayerTrackProtocol>)track time:(NSTimeInterval)time lastTime:(NSTimeInterval)lastTime;
//- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didPlayToEnd:(id<RRVideoPlayerTrackProtocol>)track;
- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didControlByEvent:(RRVideoPlayerControlEvent)event;
- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didChangeSubtitleFrom:(NSString*)fronLang to:(NSString*)toLang;
- (void)videoPlayer:(RRVideoPlayer*)videoPlayer willChangeOrientationTo:(UIInterfaceOrientation)orientation;
- (void)videoPlayer:(RRVideoPlayer*)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation;

//- (void)handleErrorCode:(RRVideoPlayerErrorCode)errorCode track:(id<RRVideoPlayerTrackProtocol>)track customMessage:(NSString*)customMessage;


@end


@interface RRVideoPlayer : NSObject<VMediaPlayerDelegate>

@property (nonatomic, strong) RRVideoPlayerView *view;

@property (nonatomic, strong) VMediaPlayer       *mMPayer;

@property (nonatomic, weak) id<RRVideoPlayerDelegate> delegate;

@property (nonatomic, copy)   NSURL *videoURL;

/** 单例的方式创建播放器 */
+(RRVideoPlayer *) sharedPlayer;



@property (nonatomic,copy)NSString * playUrl;



- (id)initWithVideoPlayerView:(RRVideoPlayerView*)videoPlayerView;

//正常播放视频的时候调用这个  时间：秒
-(void)playStreamUrl:(NSURL*)url title:(NSString*)title seekToPos:(long)pos;
//正在播放的过程中切换了播放地址，进行播放的时候用这个  时间：秒
-(void)playChangeStreamUrl:(NSURL*)url title:(NSString*)title seekToPos:(long)pos;


/** 播放 */
- (void)playContent;
/** 暂停 */
- (void)pauseContent;
#pragma mark - 卸载播放器
-(void)unInstallPlayer;

-(void)playerWillAppear;
-(void)playerDidDisAppear;



//后加的参数
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL forceRotate;
@property (nonatomic, assign) UIInterfaceOrientation visibleInterfaceOrientation;
@property (nonatomic, assign) CGRect landscapeFrame;
@property (nonatomic, assign) CGRect portraitFrame;






@end










