//
//  LoadingView.m
//  RollClient
//
//  Created by Tengfei on 16/4/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()


@property (nonatomic,assign)CGFloat viewWith;

@end

@implementation LoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.viewWith = self.frame.size.width;
        self.backgroundColor = KColor(48, 197, 255);
//        self.frame.size.width = 0.0;
        CGRect rect = self.frame;
        rect.size.width = 0;
        self.frame = rect;
//        self.frame.si
    }
    return self;
}

-(void)startLoadProgressAnimation{
    __weak __typeof(self)weakself = self;

    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)endLoadProgressAnimation{
    __weak __typeof(self)weakself = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = weakself.frame;
        rect.size.width = self.viewWith;
        weakself.frame = rect;
    } completion:^(BOOL finished) {
        weakself.hidden = YES;
    }];
}

@end
