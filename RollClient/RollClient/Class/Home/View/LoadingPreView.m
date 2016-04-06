//
//  LoadingPreView.m
//  RollClient
//
//  Created by Tengfei on 16/4/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "LoadingPreView.h"

@implementation LoadingPreView{
    CAShapeLayer *circleLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        circleLayer = [[CAShapeLayer alloc] init];
//        circleLayer.frame = 
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor grayColor].CGColor;
        circleLayer.lineWidth = 10.f;
        CGPoint point = self.center;
        point.y -= 80;
        circleLayer.path = [UIBezierPath bezierPathWithArcCenter:point radius:80 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
        circleLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:circleLayer];
        [self loadingAnimation];
    }
    return  self;
}

- (void)loadingAnimation {
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[strokeStartAnimation,strokeEndAnimation];
    group.repeatCount = 10;
    group.duration = 2.4;
    [circleLayer addAnimation:group forKey:nil];
    
}


@end
