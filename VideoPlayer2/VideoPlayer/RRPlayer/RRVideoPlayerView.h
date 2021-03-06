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



@protocol RRVideoPlayerViewDelegate <NSObject>
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

-(void)switchVideoViewModeButtonAction;

#pragma mark - 右上和右下的几个按钮被点击
- (void)lockScreenTapped;//修改，增加锁屏

- (void)shareButtonTapped;//点击分享按钮

- (void)suggestButtonTapped;//点击上报按钮

- (void)selectMenuButtonTapped;//点击选择集数

- (void)isAllowDanmu;//是否允许开启弹幕

-(void)clarityButtonTapped;//选择清晰度

//进度条相关

-(void)progressSliderUp:(float)value;

//得到当前的播放时间
-(long)getCurrentDuration;

//得到总的的播放时间
-(long)getTotalDuration;

-(void)progressSliderTapped:(CGFloat)percentage;
-(void)progressSliderDownAction;

//快进快推
-(void)endFastWithTime:(long)time;
@end

@interface RRVideoPlayerView : UIView
/** 初始化播放控件 */
+(instancetype)videoPlayerView;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *singleGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleGesture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;
@property (nonatomic, strong) IBOutlet UIButton* doneButton;
/** 播放暂定按钮 */
@property (nonatomic, weak) IBOutlet UIButton *startPause;
@property (nonatomic, strong) IBOutlet UIButton* bigPlayButton;

@property (nonatomic, weak) IBOutlet UIButton *prevBtn;
@property (nonatomic, weak) IBOutlet UIButton *nextBtn;
@property (nonatomic, weak) IBOutlet UIButton *modeBtn;
@property (nonatomic, weak) IBOutlet UIButton *reset;
@property (nonatomic, weak) IBOutlet TFVSegmentSlider *progressSld;
@property (nonatomic, weak) IBOutlet UILabel  *curPosLbl;
@property (nonatomic, weak) IBOutlet UILabel  *durationLbl;
@property (nonatomic, weak) IBOutlet UILabel  *bubbleMsgLbl;//
@property (nonatomic, weak) IBOutlet UILabel  *downloadRate;//下载速度显示
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityCarrier;
@property (nonatomic, weak) IBOutlet UIView  	*activityCarrier;
@property (nonatomic, weak) IBOutlet UIView  	*backView;
@property (nonatomic, weak) IBOutlet UIView  	*carrier;
@property (nonatomic, weak) IBOutlet UIView  	*loadbgView;//加载的背景view


@property (weak, nonatomic) IBOutlet UIButton *shareBtn;//分享
/** 清晰度 */
@property (weak, nonatomic) IBOutlet UIButton *clarityButton;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn;//上报
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;//选集
@property (weak, nonatomic) IBOutlet UIButton *smallLockBtn;//小锁屏
@property (weak, nonatomic) IBOutlet UIButton *danMuBtn;//弹幕按钮
@property (weak, nonatomic) IBOutlet UIButton *inputDanmuBtn;//写弹幕
@property (nonatomic, weak) IBOutlet UIButton* fullscreenButton;

@property (nonatomic, copy)   NSURL *videoURL;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (weak, nonatomic) IBOutlet UIView *topControl;
@property (weak, nonatomic) IBOutlet UIView *bottomControl;
@property (weak, nonatomic) IBOutlet UIButton *trackBtn;

-(IBAction)goBackButtonAction:(id)sender;

#pragma mark - 切换音轨
- (IBAction)changeTrack:(UIButton *)sender;

#pragma mark - 开始 暂停
-(IBAction)startPauseButtonAction:(UIButton *)sender;

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

#pragma mark - 手势
- (IBAction)handleSingleTap:(id)sender;
- (IBAction)handleTwoTap:(id)sender;


/**NSTimer对象 */
@property (nonatomic,strong)NSTimer * timer;


#pragma mark 分享
- (IBAction)shareButtonTapped:(UIButton *)sender;

//#pragma mark 上报
//- (IBAction)suggestButtonTapped:(UIButton *)sender;
#pragma mark 选集
- (IBAction)selectMenuButtonTapped:(UIButton *)sender;

- (IBAction)clarityButtonTapped:(UIButton *)sender;
- (IBAction)handDanmuAction:(UIButton *)sender ;

- (IBAction)inputDanmuAction:(UIButton *)sender;

- (IBAction)fullscreenButtonTapped:(UIButton *)sender;

#pragma mark - 锁屏按钮
- (IBAction)lockButtonClick:(UIButton *)sender;

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
@property (nonatomic, assign) BOOL isLockBtnEnable;//屏幕锁


/**
 *  v3是否小屏播放 - NO：展示锁屏按钮
 */
@property (nonatomic,assign)BOOL isSmallPlayShow;

// ******//

@property (nonatomic, weak) id<RRVideoPlayerViewDelegate> delegate;



- (void)layoutForOrientation:(UIInterfaceOrientation)interfaceOrientation;


-(void)startActivityWithMsg:(NSString *)msg;

-(void)stopActivity;
-(void)setBtnEnableStatus:(BOOL)enable;





@end






