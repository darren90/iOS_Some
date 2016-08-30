//
//  Base_TableViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/6/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Base_TableViewController.h"
#import "UIView+AutoLayout.h"

@interface Base_TableViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation Base_TableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Base_TableViewController"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Base_TableViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    //    self.noDataView;
    [self initTableview];
}

-(void)initTableview
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.frame = self.view.bounds;
    [tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 控制"没有数据"的提醒
    //    self.noDataView.hidden = (self.deals.count != 0);
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
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




