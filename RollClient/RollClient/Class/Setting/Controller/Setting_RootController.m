//
//  Setting_RootController.m
//  RollClient
//
//  Created by Fengtf on 16/3/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Setting_RootController.h"
#import "SettingCell.h"
#import "AboutViewController.h"
#import "SettingItem.h"
#import "Global.h"

@interface Setting_RootController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation Setting_RootController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"设置"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"设置"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    NSArray *array = self.dataArray[indexPath.section];
    cell.item = array[indexPath.row];
//    cell.backgroundColor = KRandomColor;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000000001;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = self.dataArray[indexPath.section];
    
    SettingItem *model = array[indexPath.row];
    if ([model.title isEqualToString:@"应用评分"]) {
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if  ([model.title isEqualToString:@"关于"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AboutViewController *aboutVc = [sb instantiateViewControllerWithIdentifier:@"AboutView"];
        [self.navigationController pushViewController:aboutVc animated:YES];
        
    }else if  ([model.title isEqualToString:@"我的收藏"]){
       
        
    }else if  ([model.title isEqualToString:@"清除缓存"]){
        NSString * path = [WdCleanCaches CachesDirectory];
        double cacheSize = [WdCleanCaches sizeWithFilePaht:path];
        //hud
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        SVProgressHUD.minimumDismissTimeInterval = 0.6;

        if (cacheSize == 0) {
            [SVProgressHUD showInfoWithStatus:@"无缓存，不需要清理"];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"清理了%.1fMB的缓存",cacheSize]];

        [WdCleanCaches clearCachesWithFilePath:path];
        [Global clearCache];
        model.subtitle = [NSString stringWithFormat:@"%.1fMB",0.0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        SettingItem *m10 = [SettingItem itemWithIcon:@"icon_me_collect" title:@"我的收藏"];
        
        NSString * path = [WdCleanCaches CachesDirectory];
        double cacheSize = [WdCleanCaches sizeWithFilePaht:path];
        NSString *cacheStr = [NSString stringWithFormat:@"%.1fMB",cacheSize];
        SettingItem *m20 = [SettingItem itemWithIcon:@"icon_me_delete" title:@"清除缓存" subtitle:cacheStr];
         
        SettingItem *m30 = [SettingItem itemWithIcon:@"icon_me_review" title:@"应用评分"];
        SettingItem *m31 = [SettingItem itemWithIcon:@"abouts" title:@"关于"];
        
        [_dataArray addObjectsFromArray:@[@[m10],@[m20],@[m30,m31]]];
    }
    return _dataArray;
}


@end
