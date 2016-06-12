//
//  RRVideoPlayerView.h
//  VideoPlayer
//
//  Created by Fengtf on 16/6/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFUtilities.h"
#import "TFVSegmentSlider.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ForwardBackView.h"
#import "UIAlertView+Blocks.h"



@protocol VKVideoPlayerViewDelegate <NSObject>
//@property (nonatomic, readonly) VKVideoPlayerTrack* videoTrack;
@property (nonatomic, readonly) UIInterfaceOrientation visibleInterfaceOrientation;
- (void)fullScreenButtonTapped;
- (void)playButtonPressed;
- (void)pauseButtonPressed;

- (void)nextTrackButtonPressed;
- (void)previousTrackButtonPressed;
- (void)rewindButtonPressed;

- (void)nextTrackBySwipe;
- (void)previousTrackBySwipe;

- (void)captionButtonTapped;
- (void)videoQualityButtonTapped;

- (void)doneButtonTapped;

- (void)playerViewSingleTapped;

- (void)scrubbingBegin;

- (void)scrubbingEnd;

- (void)lockScreenTapped;//lhy修改，增加锁屏

- (void)shareButtonTapped;//点击分享按钮

- (void)suggestButtonTapped;//点击上报按钮

- (void)selectMenuButtonTapped;//点击选择集数

- (void)isAllowDanmu;//是否允许开启弹幕
@end

@interface RRVideoPlayerView : UIView
/** 初始化播放控件 */
+(instancetype)videoPlayerView;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *singleGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleGesture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;

/** 播放暂定按钮 */
@property (nonatomic, weak) IBOutlet UIButton *startPause;
@property (nonatomic, weak) IBOutlet UIButton *prevBtn;
@property (nonatomic, weak) IBOutlet UIButton *nextBtn;
@property (nonatomic, weak) IBOutlet UIButton *modeBtn;
@property (nonatomic, weak) IBOutlet UIButton *reset;
@property (nonatomic, weak) IBOutlet TFVSegmentSlider *progressSld;
@property (nonatomic, weak) IBOutlet UILabel  *curPosLbl;
@property (nonatomic, weak) IBOutlet UILabel  *durationLbl;
@property (nonatomic, weak) IBOutlet UILabel  *bubbleMsgLbl;
@property (nonatomic, weak) IBOutlet UILabel  *downloadRate;
@property (nonatomic, weak) IBOutlet UIView  	*activityCarrier;
@property (nonatomic, weak) IBOutlet UIView  	*backView;
@property (nonatomic, weak) IBOutlet UIView  	*carrier;

@property (nonatomic, copy)   NSURL *videoURL;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) BOOL progressDragging;

@property (weak, nonatomic) IBOutlet UIView *topControl;
@property (weak, nonatomic) IBOutlet UIView *bottomControl;
@property (weak, nonatomic) IBOutlet UIButton *trackBtn;

-(IBAction)goBackButtonAction:(id)sender;

#pragma mark - 切换音轨
- (IBAction)changeTrack:(UIButton *)sender;

#pragma mark - 开始 暂停
-(IBAction)startPauseButtonAction:(id)sender;

-(IBAction)prevButtonAction:(id)sender;

-(IBAction)nextButtonAction:(id)sender;

#pragma mark - 切换Model
-(IBAction)switchVideoViewModeButtonAction:(id)sender;
#pragma mark - reset
-(IBAction)resetButtonAction:(id)sender;

#pragma mark - 进度条相关
-(IBAction)progressSliderDownAction:(id)sender;
-(IBAction)progressSliderUpAction:(id)sender;
-(IBAction)dragProgressSliderAction:(id)sender;

#pragma mark - 单击手势
- (IBAction)handleSingleTap:(id)sender;

- (IBAction)handleTwoTap:(id)sender;
- (IBAction)lockButtonClick:(UIButton *)sender;

/**NSTimer对象 */
@property (nonatomic,strong)NSTimer * timer;


#pragma mark - 自定义播放器需要的一些参数
/** 时间栏是否隐藏 */
@property (nonatomic,assign)BOOL isStatusBarHidden;

@property (nonatomic, assign) CGPoint curTickleStart;

//@property (nonatomic,assign)SwipeStyle swipeType;

//*快进view*/
@property (nonatomic,weak)ForwardBackView * forwardView;

//音轨的数组
@property (nonatomic,strong)NSMutableArray * trackArray;


@property (nonatomic,strong)NSURL *PrevMediaUrl;

@end
