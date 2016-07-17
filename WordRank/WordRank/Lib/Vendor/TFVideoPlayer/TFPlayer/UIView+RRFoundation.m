//
//  UIView+RRFoundation.m
//  VideoPlayer
//
//  Created by Fengtf on 16/6/14.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "UIView+RRFoundation.h"

@implementation UIView (RRFoundation)

- (void)setFrameWidth:(CGFloat)newWidth {
    CGRect f = self.frame;
    f.size.width = newWidth;
    self.frame = f;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    CGRect f = self.frame;
    f.size.height = newHeight;
    self.frame = f;
}

- (void)setFrameOriginX:(CGFloat)newX {
    CGRect f = self.frame;
    f.origin.x = newX;
    self.frame = f;
}

- (void)setFrameOriginY:(CGFloat)newY {
    CGRect f = self.frame;
    f.origin.y = newY;
    self.frame = f;
}

@end
