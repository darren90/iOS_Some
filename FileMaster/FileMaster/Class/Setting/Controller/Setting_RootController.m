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
#import "ShareActivity.h"

//扫一扫
 

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
//        [self saoyisao];
    }else if([model.title isEqualToString:@"分享给朋友"]){
        [self shareActionTapped];
    }
}




-(void)shareActionTapped
{
    //要分享的内容，加在一个数组里边，初始化UIActivityViewController
    NSString *textToShare = @"我是且行且珍惜_iOS，欢迎关注我！";
    UIImage *imageToShare = [UIImage imageNamed:@"movie_icon"];
    NSURL *urlToShare = [NSURL URLWithString:@"https://github.com/wslcmk"];
    NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
    
    //自定义Activity
    ShareActivity * custom = [[ShareActivity alloc] initWithTitie:@"且行且珍惜_iOS" withActivityImage:[UIImage imageNamed:@"wang"] withUrl:urlToShare withType:@"customActivity" withShareContext:activityItems];
    NSArray *activities = @[custom];
    
    /**
     创建分享视图控制器
     
     ActivityItems  在执行activity中用到的数据对象数组。数组中的对象类型是可变的，并依赖于应用程序管理的数据。例如，数据可能是由一个或者多个字符串/图像对象，代表了当前选中的内容。
     
     Activities  是一个UIActivity对象的数组，代表了应用程序支持的自定义服务。这个参数可以是nil。
     
     */
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:activities];
    
    //UIActivityViewControllerCompletionWithItemsHandler)(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError)  iOS >=8.0
    
    //UIActivityViewControllerCompletionHandler (NSString * __nullable activityType, BOOL completed); iOS 6.0~8.0
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        //初始化回调方法
        UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError)
        {
            NSLog(@"activityType :%@", activityType);
            if (completed)
            {
                NSLog(@"completed");
            }
            else
            {
                NSLog(@"cancel");
            }
            
        };
        
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        activityVC.completionWithItemsHandler = myBlock;
    }else{
        
        UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType,BOOL completed)
        {
            NSLog(@"activityType :%@", activityType);
            if (completed)
            {
                NSLog(@"completed");
            }
            else
            {
                NSLog(@"cancel");
            }
            
        };
        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
        activityVC.completionHandler = myBlock;
    }
    
    //Activity 类型又分为“操作”和“分享”两大类
    /*
     UIKIT_EXTERN NSString *const UIActivityTypePostToFacebook     NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypePostToTwitter      NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypePostToWeibo        NS_AVAILABLE_IOS(6_0);    //SinaWeibo
     UIKIT_EXTERN NSString *const UIActivityTypeMessage            NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypeMail               NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypePrint              NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypeCopyToPasteboard   NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypeAssignToContact    NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypeSaveToCameraRoll   NS_AVAILABLE_IOS(6_0);
     UIKIT_EXTERN NSString *const UIActivityTypeAddToReadingList   NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIActivityTypePostToFlickr       NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIActivityTypePostToVimeo        NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIActivityTypePostToTencentWeibo NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIActivityTypeAirDrop            NS_AVAILABLE_IOS(7_0);
     */
    
    // 分享功能(Facebook, Twitter, 新浪微博, 腾讯微博...)需要你在手机上设置中心绑定了登录账户, 才能正常显示。
    //关闭系统的一些activity类型
    activityVC.excludedActivityTypes = @[];
    
    //在展现view controller时，必须根据当前的设备类型，使用适当的方法。在iPad上，必须通过popover来展现view controller。在iPhone和iPodtouch上，必须以模态的方式展现。
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        SettingModel *m01 = [SettingModel settingIconName:@"saoyisao_s" title:@"扫一扫"];
        SettingModel *m02 = [SettingModel settingIconName:@"share_s" title:@"分享给朋友"];

        SettingGroup *g0 = [[SettingGroup alloc]init];
        g0.header = @"扩展";
        g0.items = @[m01,m02];
        
        
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



















