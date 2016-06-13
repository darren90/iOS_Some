//
//  RRVideoPlayerView.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/12.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RRVideoPlayerView.h"

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

    
    
    [self addHiddeControlTimer];
}


-(IBAction)goBackButtonAction:(id)sender
{
    NSLog(@"%s",__func__);
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
    self.progressDragging = YES;
    //	NSLog(@"NAL 4HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
    //	NSLog(@"NAL 1DOW &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& Touch Down");
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
    long duration = [self.delegate getDuration];
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
    long seek = percentage * [self.delegate getDuration];
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

#pragma mark - 单击手势
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
    if (!self.timer) {
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

@end
