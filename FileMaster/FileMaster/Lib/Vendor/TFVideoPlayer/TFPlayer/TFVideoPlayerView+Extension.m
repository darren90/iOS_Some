//
//  RRVideoPlayerView+Extension.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/14.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFVideoPlayerView+Extension.h"

static CGFloat BTNWIDTH = 40.0;
static CGFloat BTNHIGHT = 40.0;
static CGFloat SPACE    = 10.0;
static CGFloat LABELHIGHT = 20.0;

#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


@implementation TFVideoPlayerView (Extension)

- (void)allHidden{

//    [self setControlsHidden:YES];

}

- (void)hiddenSomeControls{
    //self.titleLabel.hidden = YES;
    self.clarityButton.hidden = YES;
    self.lockButton.hidden = YES;
    self.shareBtn.hidden = YES;
    self.suggestBtn.hidden = YES;
    self.selectBtn.hidden = YES;
    self.isSmallPlayShow = YES;
}

- (void)layoutSliderForOrientation:(UIInterfaceOrientation)interfaceOrientation{

    if (self.isSmallPlayShow) {

        self.durationLbl.frame = CGRectMake(X(self.fullscreenButton) - WIDTH(self.durationLbl), (HEIGHT(self.bottomControl) - LABELHIGHT)/2, WIDTH(self.durationLbl), LABELHIGHT);
        self.curPosLbl.frame = CGRectMake(X(self.durationLbl) - WIDTH(self.curPosLbl), Y(self.durationLbl), WIDTH(self.curPosLbl), LABELHIGHT);
        self.progressSld.frame = CGRectMake(MaxX(self.startPause), (HEIGHT(self.bottomControl) - HEIGHT(self.progressSld))/2, X(self.curPosLbl) - MaxX(self.startPause), HEIGHT(self.progressSld));

    }else{

        self.curPosLbl.frame = CGRectMake(SPACE, Y(self.fullscreenButton) + 12, WIDTH(self.curPosLbl), LABELHIGHT);
        self.durationLbl.frame   = CGRectMake(MaxX(self.curPosLbl), Y(self.curPosLbl), WIDTH(self.durationLbl), LABELHIGHT);
        self.inputDanmuBtn.frame    = CGRectMake(MaxX(self.durationLbl) + 10, Y(self.durationLbl) - 3, X(self.danMuBtn) - MaxX(self.durationLbl) - 2*SPACE, 22);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self layout];

}

- (void)layout{
    
    [self.bigPlayButton removeFromSuperview];
    
    if (self.isSmallPlayShow){
        //小屏下的布局
        self.startPause.hidden = NO;
        self.inputDanmuBtn.hidden = YES;
        self.fullscreenButton.frame = CGRectMake(WIDTH(self) - BTNWIDTH, (HEIGHT(self.bottomControl) - BTNHIGHT)/2, BTNWIDTH, BTNHIGHT);
        self.smallLockBtn.frame = CGRectZero;
        self.danMuBtn.frame = CGRectZero;
        self.inputDanmuBtn.frame = CGRectZero;
        self.durationLbl.frame = CGRectMake(X(self.fullscreenButton) - WIDTH(self.durationLbl), (HEIGHT(self.bottomControl) - LABELHIGHT)/2, WIDTH(self.durationLbl), LABELHIGHT);
        self.curPosLbl.frame = CGRectMake(X(self.durationLbl) - WIDTH(self.curPosLbl), Y(self.durationLbl), WIDTH(self.curPosLbl), LABELHIGHT);
        self.progressSld.frame = CGRectMake(MaxX(self.startPause), (HEIGHT(self.bottomControl) - HEIGHT(self.progressSld))/2, X(self.curPosLbl) - MaxX(self.startPause), HEIGHT(self.progressSld));
        self.titleLabel.frame = CGRectMake(MaxX(self.doneButton), Y(self.doneButton) + (HEIGHT(self.doneButton) - HEIGHT(self.titleLabel))/2, WIDTH(self) - 60, HEIGHT(self.titleLabel));

    }else{
        //大屏下的布局
        self.startPause.hidden = NO;
        self.inputDanmuBtn.hidden = NO;
        self.startPause.frame = CGRectMake(10, 6, WIDTH(self.startPause), HEIGHT(self.startPause));
        self.fullscreenButton.frame = CGRectMake(WIDTH(self) - BTNWIDTH, HEIGHT(self.bottomControl) - BTNHIGHT, BTNWIDTH, BTNHIGHT);
        self.smallLockBtn.frame = CGRectMake(X(self.fullscreenButton) - BTNWIDTH - SPACE, Y(self.fullscreenButton), BTNWIDTH, BTNHIGHT);
        self.danMuBtn.frame = CGRectMake(X(self.smallLockBtn) - BTNWIDTH - SPACE, Y(self.fullscreenButton), BTNWIDTH, BTNHIGHT);
        self.curPosLbl.frame = CGRectMake(MaxX(self.startPause), Y(self.fullscreenButton) + 12+6, WIDTH(self.curPosLbl), LABELHIGHT);
        self.durationLbl.frame = CGRectMake(MaxX(self.curPosLbl), Y(self.curPosLbl), WIDTH(self.durationLbl), LABELHIGHT);
        self.progressSld.frame = CGRectMake(0, -13, WIDTH(self.bottomControl) + 10, HEIGHT(self.progressSld));
        self.inputDanmuBtn.frame = CGRectMake(MaxX(self.durationLbl) + 10, Y(self.durationLbl) - 3, X(self.danMuBtn) - MaxX(self.durationLbl) - 2*SPACE, 22);
        self.titleLabel.frame = CGRectMake(MaxX(self.doneButton), Y(self.doneButton) + (HEIGHT(self.doneButton) - HEIGHT(self.titleLabel))/2, MaxX(self.shareBtn) - 50, HEIGHT(self.titleLabel));
        self.loadbgView.frame = CGRectMake((WIDTH(self.bottomControl) - WIDTH(self.loadbgView))/2, MinY(self.bottomControl)-HEIGHT(self.loadbgView)-20, WIDTH(self.loadbgView), HEIGHT(self.loadbgView));
        
        self.bigPlayButton.frame = CGRectMake((KWidth-WIDTH(self.bigPlayButton))/2, (KHeight-HEIGHT(self.bigPlayButton))/2, WIDTH(self.bigPlayButton), HEIGHT(self.bigPlayButton));
        
    }
}
@end
