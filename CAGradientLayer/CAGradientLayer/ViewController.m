//
//  ViewController.m
//  CAGradientLayer
//
//  Created by Tengfei on 16/7/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.、
    
    //  创建 UIView 用来承载渐变色
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 200)];
    [self.view addSubview:myView];
    
    
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    //  设置 gradientLayer 的 Frame
    gradientLayer.frame = myView.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor blueColor].CGColor];
    
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@(0.1f) ,@(0.4f)];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //  添加渐变色到创建的 UIView 上去
    [myView.layer addSublayer:gradientLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
