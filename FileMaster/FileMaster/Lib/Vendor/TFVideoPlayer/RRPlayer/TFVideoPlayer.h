//
//  TFVideoPlayer.m
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFVideoPlayerView.h"
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
    
} TFVideoPlayerErrorCode;


typedef enum {
    TFVideoPlayerStateUnknown,
    TFVideoPlayerStateContentLoading,
    TFVideoPlayerStateContentPlaying,
    TFVideoPlayerStateContentPaused,
    TFVideoPlayerStateSuspend,
    TFVideoPlayerStateDismissed,
    TFVideoPlayerStateError
} TFVideoPlayerState;

typedef enum {
    TFVideoPlayerControlEventTapPlayerView,
    TFVideoPlayerControlEventTapNext,
    TFVideoPlayerControlEventTapPrevious,
    TFVideoPlayerControlEventTapDone,
    TFVideoPlayerControlEventTapFullScreen,
    TFVideoPlayerControlEventTapCaption,
    TFVideoPlayerControlEventTapVideoQuality,
    TFVideoPlayerControlEventSwipeNext,
    TFVideoPlayerControlEventSwipePrevious,
    TFVideoPlayerControlEventShare,//分享
    TFVideoPlayerControlEventSuggest,//反馈
    TFVideoPlayerControlEventSelectMenu,//选集
    TFVideoPlayerControlEventPause,//暂停
    TFVideoPlayerControlEventPlay,//播放
    TFVideoplayercontroleventDanMu,//弹幕
    TFVideoplayercontroleventClarity,//清晰度
} TFVideoPlayerControlEvent;


@class TFVideoPlayer;
@protocol TFVideoPlayerDelegate <NSObject>
@optional
- (BOOL)shouldVideoPlayer:(TFVideoPlayer*)videoPlayer changeStateTo:(TFVideoPlayerState)toState;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer willChangeStateTo:(TFVideoPlayerState)toState;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didChangeStateFrom:(TFVideoPlayerState)fromState;
//- (BOOL)shouldVideoPlayer:(TFVideoPlayer*)videoPlayer startVideo:(id<TFVideoPlayerTrackProtocol>)track;
//- (void)videoPlayer:(TFVideoPlayer*)videoPlayer willStartVideo:(id<TFVideoPlayerTrackProtocol>)track;
//- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didStartVideo:(id<TFVideoPlayerTrackProtocol>)track;
//
//- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didPlayFrame:(id<TFVideoPlayerTrackProtocol>)track time:(NSTimeInterval)time lastTime:(NSTimeInterval)lastTime;
//- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didPlayToEnd:(id<TFVideoPlayerTrackProtocol>)track;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didChangeSubtitleFrom:(NSString*)fronLang to:(NSString*)toLang;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer willChangeOrientationTo:(UIInterfaceOrientation)orientation;
- (void)videoPlayer:(TFVideoPlayer*)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation;

//- (void)handleErrorCode:(TFVideoPlayerErrorCode)errorCode track:(id<TFVideoPlayerTrackProtocol>)track customMessage:(NSString*)customMessage;


@end


@interface TFVideoPlayer : NSObject<VMediaPlayerDelegate>

@property (nonatomic, strong) TFVideoPlayerView *view;

@property (nonatomic, strong) VMediaPlayer       *mMPayer;

@property (nonatomic, weak) id<TFVideoPlayerDelegate> delegate;

@property (nonatomic, copy)   NSURL *videoURL;

/** 单例的方式创建播放器 */
+(TFVideoPlayer *) sharedPlayer;



@property (nonatomic,copy)NSString * playUrl;



- (id)initWithVideoPlayerView:(TFVideoPlayerView*)videoPlayerView;

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
/**
 *  是否播放的是本地资源
 */
@property (nonatomic,assign)BOOL isPlayLocalFile;//我增加的字段，以便播放本地视频的时候视频不受打扰






@end










