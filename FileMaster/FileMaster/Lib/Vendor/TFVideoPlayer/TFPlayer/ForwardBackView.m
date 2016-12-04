//
//  ForwardBackView.m
//  VideoPlayer
//
//  Created by Tengfei on 16/6/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ForwardBackView.h"

@implementation ForwardBackView
{
    UIImageView * forwardImage;
    UILabel * seconds;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.cornerRadius = 2;
        self.backgroundColor = [UIColor colorWithHue:20/255.0 saturation:20/255.0 brightness:20/255.0 alpha:1.0];
        
        forwardImage = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 40)/2, 6, 30, 20)];
        forwardImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:forwardImage];
        
        seconds = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(forwardImage.frame) + 3, frame.size.width - 6, 16)];
        seconds.font = [UIFont boldSystemFontOfSize:10];
        seconds.textColor = [UIColor whiteColor];
        seconds.textAlignment = NSTextAlignmentCenter;
        seconds.adjustsFontSizeToFitWidth = YES;
        [self addSubview:seconds];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    forwardImage.frame = CGRectMake((self.frame.size.width - 40)/2, 6, 30, 20);
    
    seconds.frame = CGRectMake(3, CGRectGetMaxY(forwardImage.frame) + 3, self.frame.size.width - 6, 16);
}

- (void)setDirection:(ForwardDirection)direction
{
    if (direction) {
        forwardImage.image = [UIImage imageNamed:@"left"];
    }else{
        forwardImage.image = [UIImage imageNamed:@"right"];
    }
}

- (void)setTime:(NSString *)time
{
    if (time) {
        seconds.text = time;
    }
}

@end


