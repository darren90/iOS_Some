//
//  BaseViewController.m
//  RollClient
//
//  Created by Fengtf on 16/3/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"BaseViewController"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"BaseViewController"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.noDataView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UIImageView *)noDataView
{
    if (!_noDataView) {
        // 添加一个"没有数据"的提醒
        UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodata_image"]];
        [self.view addSubview:noDataView];
        [noDataView autoCenterInSuperview];
        self.noDataView = noDataView;
    }
    return _noDataView;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
