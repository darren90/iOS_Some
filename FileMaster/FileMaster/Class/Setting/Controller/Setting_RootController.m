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

//扫一扫
#import "SubLBXScanViewController.h"
//#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
//#import "ScanResultViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"

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
    }else if([model.title isEqualToString:@"扫一扫"]){
        [self saoyisao];
    }
}



-(void)saoyisao
{
    if (![self cameraPemission])
    {
        NSLog(@"没有摄像机权限");
//        [self showError:@"没有摄像机权限"];
        return;
    }
}


#pragma mark -模仿qq界面
- (void)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)cameraPemission
{
    
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    
    return isHavePemission;
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        SettingModel *m01 = [SettingModel settingIconName:@"saoyisaos" title:@"扫一扫"];
        SettingGroup *g0 = [[SettingGroup alloc]init];
        g0.header = @"扩展";
        g0.items = @[m01];
        
        
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

        [_dataArray addObject:g0];
        [_dataArray addObject:g2];
        [_dataArray addObject:g1];
        [_dataArray addObject:g3];
    }
    return _dataArray;
}

@end



















