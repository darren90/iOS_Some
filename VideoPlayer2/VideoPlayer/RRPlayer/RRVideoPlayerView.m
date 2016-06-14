//
//  RRVideoPlayerView.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RRVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"

//手指移动的方向
typedef NS_ENUM(NSInteger,PanDirection) {
    PanDirectionHorizontalMoved,
    PanDirectionVerticalMoved,
} ;


@interface RRVideoPlayerView ()

/** 调节声音，亮度；快进快推的手势 */
@property (nonatomic,strong)UIPanGestureRecognizer * panGesture;

@property (nonatomic, assign) PanDirection panDirection;//滑动方向


@property (nonatomic,assign)BOOL isVolume;//是否是音量 亮度
@property (nonatomic,assign)long sumTime;//快进的总量
@property (nonatomic,assign)BOOL isEndFast;//判断是否快进
@property (nonatomic,strong)UISlider * volumeViewSlider;//音量view

@end

@implementation RRVideoPlayerView

+(instancetype)videoPlayerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"RRVideoPlayerView" owner:nil options:nil].firstObject;
}

-(instancetype)init
{
    if (self = [super init]) {
        self = [RRVideoPlayerView videoPlayerView];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.clipsToBounds = YES;
}

-(void)initialize
{
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(progressSliderTapped:)];
    [self.progressSld addGestureRecognizer:gr];
    
    //当前点点的位置
    [self.progressSld setThumbImage:[UIImage imageNamed:@"pb-seek-bar-btn@2x.png"] forState:UIControlStateNormal];
    //已播放的条的颜色
    [self.progressSld setMinimumTrackImage:[UIImage imageNamed:@"pb-seek-bar-fr@2x.png"] forState:UIControlStateNormal];
    //未播放的条的颜色
    [self.progressSld setMaximumTrackImage:[UIImage imageNamed:@"pb-seek-bar-bg@2x.png"] forState:UIControlStateNormal];
    
    //这句话的意思时，只有当doubleTapGesture识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别，同我们一开始讲的是同一个问题。
    [self.singleGesture requireGestureRecognizerToFail:self.doubleGesture];

    //添加手势 音量 亮度 快进
    if (!self.panGesture) {
        self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
        [self addGestureRecognizer:self.panGesture];
    }
    
    
    [self addHiddeControlTimer];
    
    //声音调节的空间
    [self configureVolume];
    //快进快推
    [self configureSpeedView];
}


- (void)delPlayerPanGesture{
    [self removeGestureRecognizer:self.panGesture];
    self.panGesture = nil;
}

-(IBAction)goBackButtonAction:(id)sender
{
    NSLog(@"%s",__func__);
    [self.delegate doneButtonTapped];
}

#pragma mark - 切换音轨
- (IBAction)changeTrack:(UIButton *)sender
{
    
}

#pragma mark - 开始 暂停
-(IBAction)startPauseButtonAction:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    if (self.isLockBtnEnable) {
//        [self showLockBtn];//显示锁屏按钮
        return;
    }
    if (sender.selected)  {//播放
        [self.delegate playButtonPressed];
        [self setPlayButtonsSelected:NO];
    } else {//暂停
        [self.delegate pauseButtonPressed];
        [self setPlayButtonsSelected:YES];
    }
}

-(IBAction)prevButtonAction:(id)sender
{
    
}

-(IBAction)nextButtonAction:(id)sender
{
    
}

#pragma mark - 切换Model
-(IBAction)switchVideoViewModeButtonAction:(id)sender
{
    
}
#pragma mark - reset
-(IBAction)resetButtonAction:(id)sender
{
    
}

#pragma mark - 进度条相关
-(IBAction)progressSliderDownAction:(id)sender
{
    //	NSLog(@"NAL 4HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
    //	NSLog(@"NAL 1DOW &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& Touch Down");
    [self.delegate progressSliderDownAction];
}

-(IBAction)progressSliderUpAction:(id)sender
{
    UISlider *sld = (UISlider *)sender;
    //	NSLog(@"NAL 1BVC &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& seek = %ld", (long)(sld.value * mDuration));
//    NSLog(@"-progressSliderUpAction--slide-value:%f,seek = %ld,t:%@",sld.value,(long)(sld.value * mDuration),[TFUtilities timeToHumanString:(long)(sld.value * mDuration)]);
//    [self startActivityWithMsg:@"Buffering"];
//    [mMPayer seekTo:(long)(sld.value * mDuration)];
    
    [self.delegate progressSliderUp:sld.value];
}

-(IBAction)dragProgressSliderAction:(id)sender
{
    UISlider *sld = (UISlider *)sender;
    NSLog(@"-dragProgressSliderAction--slide-value:%f",sld.value);
    long duration = [self.delegate getCurrentDuration];
    self.curPosLbl.text = [TFUtilities timeToHumanString:(long)(sld.value * duration)];
}

-(void)progressSliderTapped:(UIGestureRecognizer *)g
{
    UISlider* s = (UISlider*)g.view;
    if (s.highlighted)
        return;
    CGPoint pt = [g locationInView:s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = s.minimumValue + delta;
    [s setValue:value animated:YES];
    long seek = percentage * [self.delegate getCurrentDuration];
    self.curPosLbl.text = [TFUtilities timeToHumanString:seek];
//    self.curPosLbl.text = [TFUtilities timeToHumanString:seek];
//    NSLog(@"NAL 2BVC &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& seek = %ld", seek);
//    [self startActivityWithMsg:@"Buffering"];
//    [mMPayer seekTo:seek];
    [self.delegate progressSliderTapped:percentage];
}

#pragma mark Others

-(void)startActivityWithMsg:(NSString *)msg
{
    self.bubbleMsgLbl.hidden = NO;
    self.bubbleMsgLbl.text = msg;
    [self.activityView startAnimating];
}

-(void)stopActivity
{
    self.bubbleMsgLbl.hidden = YES;
    self.bubbleMsgLbl.text = nil;
    [self.activityView stopAnimating];
}

#pragma mark - 单击/双击 手势
- (IBAction)handleSingleTap:(id)sender
{
    //销毁计时器
    [self destroyHiddeControlTimer];
    //代理做
    if (self.isLockBtnEnable) {
        self.lockButton.hidden = !self.lockButton.hidden;
    }else{
        self.topControl.hidden = !self.topControl.hidden;
        self.bottomControl.hidden = !self.bottomControl.hidden;
        self.bigPlayButton.hidden = !self.bigPlayButton.hidden;
    }
    
    //添加计时器
    [self addHiddeControlTimer];
}

- (IBAction)handleTwoTap:(id)sender
{
    
    if (self.isLockBtnEnable) {
        return;
    }
    
    [self startPauseButtonAction:self.startPause];
}

#pragma mark - 顶部和底部控制按钮的 增加定时器
-(void)addHiddeControlTimer
{
    //     NSLog(@"---addTimer");
    if (!self.timer && !self.isLockBtnEnable) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(hiddenTopBottom) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //消息循环，添加到主线程
        //extern NSString* const NSDefaultRunLoopMode;  //默认没有优先级
        //extern NSString* const NSRunLoopCommonModes;  //提高优先级
    }
}

#pragma mark - 顶部和底部控制按钮的 销毁定时器
-(void)destroyHiddeControlTimer
{
    //    NSLog(@"---destroyTimer");
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"");
}

-(void)hiddenTopBottom
{
    if (!self.topControl.hidden) {
        self.topControl.hidden = YES;
        self.bottomControl.hidden = YES;
        self.bigPlayButton.hidden = YES;
    }
    if (self.isLockBtnEnable) {
        self.lockButton.hidden = !self.lockButton.hidden;
    }
}

- (IBAction)lockButtonClick:(UIButton *)sender
{
    self.isLockBtnEnable = !self.isLockBtnEnable;
    if (!self.isLockBtnEnable) {
        //开
        [sender setImage:[UIImage imageNamed:@"icon_kai_n"] forState:UIControlStateNormal];
        self.topControl.hidden = NO;
        self.bottomControl.hidden = NO;
        self.bigPlayButton.hidden = NO;
    }else{
        //锁
        [sender setImage:[UIImage imageNamed:@"icon_suo_h"] forState:UIControlStateNormal];
        self.topControl.hidden = YES;
        self.bottomControl.hidden = YES;
        self.lockButton.hidden = YES;
        self.bigPlayButton.hidden = YES;
    }
}

- (void)setPlayButtonsSelected:(BOOL)selected {
    self.startPause.selected = selected;
    self.bigPlayButton.selected = selected;
}

- (void)setPlayButtonsEnabled:(BOOL)enabled {
    self.startPause.enabled = enabled;
    self.bigPlayButton.enabled = enabled;
}


#pragma mark - 手势控制，声音，亮度，进度


- (void)panDirection:(UIPanGestureRecognizer *)pan{
    
    if (self.isLockBtnEnable) {
        return;
    }
    //根据在view上Pan的位置，确定是跳音量、亮度
    CGPoint locationPoint = [pan locationInView:self];
    //NSLog(@"========%@",NSStringFromCGPoint(locationPoint));
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self];
    CGPoint transPoint = [pan translationInView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"x:%f  y:%f   aaa:%f,bbb:%f",veloctyPoint.x, veloctyPoint.y,transPoint.x,transPoint.y);
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) { // 水平移动
                self.panDirection = PanDirectionHorizontalMoved;
                // 取消隐藏
                self.forwardView.hidden = NO;
                self.isEndFast = NO;
                // 给sumTime初值
                self.sumTime = [self.delegate getCurrentDuration];
//                NSTimeInterval time = self.player.currentTime;
//                self.sumTime = time;// time.value/time.timescale;
            }else if (x < y){ // 垂直移动
                self.panDirection = PanDirectionVerticalMoved;
                // 显示音量控件
                if (locationPoint.x > self.bounds.size.width / 2) {
                    self.isVolume = YES;
                }else { // 显示亮度调节
                    self.isVolume = NO;
                }
                // 开始滑动的时候，状态改为正在控制音量
            }
            
        }
            break;
        case UIGestureRecognizerStateChanged:{
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    if (!self.isEndFast) {
//                        [self.player begainFast];
                        self.isEndFast = YES;
                    }
                    [self horizontalMoved:veloctyPoint.x]; // 水平移动的方法只要x方向的值
                    break;
                }
                case PanDirectionVerticalMoved:{
                    [self verticalMoved:veloctyPoint.y]; // 垂直移动方法只要y方向的值
                    break;
                }
                default:
                    break;
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:{
            // 移动结束也需要判断垂直或者平移
            // 比如水平移动结束时，要快进到指定位置，如果这里没有判断，当我们调节音量完之后，会出现屏幕跳动的bug
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{//快进结束
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        // 隐藏视图
                        self.forwardView.hidden = YES;
                    });
//                    [self.player endFastWithTime:self.sumTime];
                    // 把sumTime滞空，不然会越加越多
                    [self.delegate endFastWithTime:self.sumTime];
                    self.sumTime = 0;
                    self.isEndFast = NO;
                }
                    break;
                    
                case PanDirectionVerticalMoved:{ // 垂直移动结束后，隐藏音量控件 且，把状态改为不再控制音量
                    
                    self.isVolume = NO;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
}
#pragma makr 调节音量
- (void)verticalMoved:(CGFloat)value{
    
    if (self.isVolume) {
        // 更改系统的音量
        self.volumeViewSlider.value -= value / 10000; // 越小幅度越小
    }else {
        //亮度
        [UIScreen mainScreen].brightness -= value / 10000;
    }
}
#pragma makr 快进后退
- (void)horizontalMoved:(CGFloat)value{
    NSLog(@"快进快推-:%f",value);
    // 快进快退的方法
    NSString *style = @"";
    if (value < 0) {
        style = @"<<";
        self.forwardView.direction = ForwardBack;
    }
    else if (value > 0){
        style = @">>";
        self.forwardView.direction = ForwardUp;
    }
    
    // 每次滑动需要叠加时间
    self.sumTime += value/1;    // 需要限定sumTime的范围
//    CMTime totalTime = self.player.playerItem.duration;
//    CGFloat totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
    long totalMovieDuration = [self.delegate getTotalDuration];
    if (self.sumTime > totalMovieDuration) {
        self.sumTime = totalMovieDuration;
    }else if (self.sumTime < 0){
        self.sumTime = 0;
    }

    NSString * currentTime = [TFUtilities timeToHumanString:self.sumTime];
    NSString * total = [TFUtilities timeToHumanString:totalMovieDuration];
    self.forwardView.time = [NSString stringWithFormat:@"%@/%@",currentTime,total];
}

#pragma mark - 快进
- (void)configureSpeedView{
    if (self.forwardView == nil) {
        ForwardBackView *forwardView = [[ForwardBackView alloc]initWithFrame:CGRectMake(0, 0, 170, 84)];
        forwardView.alpha = 0.8;
        forwardView.hidden = YES;
        [self addSubview:forwardView];
        self.forwardView = forwardView;
//        self.center = forwardView.center;
        [forwardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(84);
            make.width.mas_equalTo(170);
            make.center.equalTo(self);
        }];
    }
}

#pragma mark 获取系统音量
- (void)configureVolume{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    self.volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            self.volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
    // 使用这个category的应用不会随着手机静音键打开而静音，可在手机静音下播放声音
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    
    if (!success) { /* handle the error in setCategoryError */ }
}



@end
