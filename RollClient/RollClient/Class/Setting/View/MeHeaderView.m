//
//  MeTopView.m
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "MeHeaderView.h"

@interface MeHeaderView ()


@property (nonatomic,weak)UIImageView * iconView;

//Blur,Fuzzy,out of focus

@property (nonatomic,weak)UIImageView * blurView;


@property (nonatomic,weak)UIImageView * bgView;

@end

@implementation MeHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        // Aspect : 按照图片的原来宽高比进行缩
        // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
        // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
        // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
        
        //安装从后向前的顺序
        UIImageView *bgView = [[UIImageView alloc]init];
        [self addSubview:bgView];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgView = bgView;
        
        UIImageView *blurView = [[UIImageView alloc]init];
        [self addSubview:blurView];
        blurView.contentMode = UIViewContentModeScaleAspectFill;
        self.blurView = blurView;
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        iconView.contentMode = UIViewContentModeCenter;
        self.iconView = iconView;
//        iconView.alpha = 0.5;
        
        bgView.image = [UIImage imageNamed:@"bg_me_pic1"];
        iconView.image = [UIImage imageNamed:@"ic_me_logo"];
        blurView.image = [UIImage imageNamed:@"bg_me_pic"];

    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    self.blurView.frame = self.bounds;
    
//    472 × 204
    CGFloat iconW= 472 / 3;
    CGFloat iconH = 204 / 3;
    CGFloat margin = isApplePad ? 100 :60;
    self.iconView.frame = CGRectMake((self.frame.size.width - iconW)/2, (self.frame.size.height - iconH)/2-margin, iconW, iconH);

}

@end
