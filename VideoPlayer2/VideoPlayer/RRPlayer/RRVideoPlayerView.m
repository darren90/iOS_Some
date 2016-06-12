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
    
    
    
    
    //这句话的意思时，只有当doubleTapGesture识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别，同我们一开始讲的是同一个问题。
    [self.singleGesture requireGestureRecognizerToFail:self.doubleGesture];
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
-(IBAction)startPauseButtonAction:(id)sender
{
    NSLog(@"%s",__func__);
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
    
}
-(IBAction)progressSliderUpAction:(id)sender
{
    
}
-(IBAction)dragProgressSliderAction:(id)sender
{
    
}

#pragma mark - 单击手势
- (IBAction)handleSingleTap:(id)sender
{
    
}

- (IBAction)handleTwoTap:(id)sender
{
    
}
- (IBAction)lockButtonClick:(UIButton *)sender
{
    
}



@end
