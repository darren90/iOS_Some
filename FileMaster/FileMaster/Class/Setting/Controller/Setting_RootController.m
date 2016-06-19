//
//  SettingViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Setting_RootController.h"
#import "SettingCell.h"
#import "AboutViewController.h"
#import "SettingModel.h"
#import "SettingGroup.h"
#import "UseViewController.h"

@interface Setting_RootController ()
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
    
    self.tableView.backgroundColor = MJColor(239, 239, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    SettingGroup *group = self.dataArray[section];
    return group.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingGroup *group = self.dataArray[indexPath.section];
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    cell.model = group.items[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    if (group.header) {
        return 40;
    }
    return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    return group.header;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = MJColor(239, 239, 244);
    label.textColor = MJColor(109, 109, 109);
    label.font = [UIFont systemFontOfSize:12];
    if (group.header) {
        label.text = [NSString stringWithFormat:@"       %@",group.header];
    }
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    if (group.footer) {
        return 40;
    }
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    return group.footer;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = MJColor(239, 239, 244);
    label.textColor = MJColor(109, 109, 109);
    label.font = [UIFont systemFontOfSize:12];
    if (group.footer) {
        label.text = [NSString stringWithFormat:@"       %@",group.footer];
    }
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SettingGroup *group = self.dataArray[indexPath.section];
    SettingModel *model = group.items[indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if ([model.title isEqualToString:@"应用评分"]) {
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if  ([model.title isEqualToString:@"关于"]){
        AboutViewController *aboutVc = [sb instantiateViewControllerWithIdentifier:@"aboutVc"];
        [self.navigationController pushViewController:aboutVc animated:YES];
    
    }else if ([model.title isEqualToString:@"建议"]){
        NSString *stringURL = @"mailto:fengtenfei90@163.com";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }else if ([model.title isEqualToString:@"使用教程"]){
        UseViewController *usevc = [sb instantiateViewControllerWithIdentifier:@"usevc"];
        [self.navigationController pushViewController:usevc animated:YES];
    }
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        SettingModel *m21 = [SettingModel settingIconName:@"use_icon2" title:@"使用教程"];
//        SettingModel *m22 = [SettingModel settingIconName:@"feedBack" title:@"常见问题"];
        SettingGroup *g1 = [[SettingGroup alloc]init];
        g1.header = @"帮助";
        g1.items = @[m21];
        
        
        //group1
        SettingModel *m0 = [SettingModel settingIconName:@"feedBack" title:@"建议"];
        SettingModel *m1 = [SettingModel settingIconName:@"icon_me_review" title:@"应用评分"];
//        SettingModel *m2 = [SettingModel settingIconName:@"abouts" title:@"关于"];
        
        SettingGroup *g2 = [[SettingGroup alloc]init];
        g2.header = @"通用";
        g2.items = @[m1,m0];

        SettingModel *m31 = [SettingModel settingIconName:@"abouts" title:@"关于"];
        SettingGroup *g3 = [[SettingGroup alloc]init];
        g3.header = @"关于";
        g3.items = @[m31];
        
//        [_dataArray addObject:m1];
//        [_dataArray addObject:m0];
//        [_dataArray addObject:m2];
        [_dataArray addObject:g2];
        [_dataArray addObject:g1];
        [_dataArray addObject:g3];
    }
    return _dataArray;
}

@end



















