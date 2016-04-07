//
//  CollectionViewController.m
//  RollClient
//
//  Created by Tengfei on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "CollectionViewController.h"
#import "HomeRollCell.h"
#import "RollVideoCell.h"
#import "RollImgsCell.h"
#import "HomeDetailViewController.h"
#import "RollModel.h"

@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
- (IBAction)edit:(UIBarButtonItem *)sender;
@property (nonatomic, weak) UIImageView *noDataView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *array = [DatabaseTool getRollCollects];
    [self.dataArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 控制"没有数据"的提醒
    self.noDataView.hidden = (self.dataArray.count != 0);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RollModel *model = self.dataArray[indexPath.row];
    if ([model.itemType isEqualToString:@"1"]) {
        RollImgsCell *cell = [RollImgsCell cellWithTableView:tableView];
        cell.model = model;
        return cell;
    }else if ([model.itemType isEqualToString:@"2"]){
        RollVideoCell *cell = [RollVideoCell cellWithTableView:tableView];
        cell.model = model;
        return cell;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RollModel * model = self.dataArray[indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeDetailViewController *detail = [sb instantiateViewControllerWithIdentifier:@"HomeDetail"];
    detail.title = model.itemTitle;
    detail.itemId = model.itemId;
    detail.itemType = model.itemType;
    [self.navigationController pushViewController:detail animated:YES];
    
    //添加到已阅
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *reads = [defaults objectForKey:KHadReades];
    if (reads){
        NSMutableArray *arrs = [NSMutableArray arrayWithArray:reads];
        [arrs addObject:model.itemId];
        [defaults setObject:arrs forKey:KHadReades];
    }else{//没有的时候创建新的数组
        NSMutableArray *arr = [NSMutableArray array];
        [defaults setObject:arr forKey:KHadReades];
    }
    [defaults synchronize];
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RollModel *model = self.dataArray[indexPath.row];
    
    if ([model.itemType isEqualToString:@"1"]) {
        if (isApplePad){
            return 200;
        }
        return 120;
    }else if ([model.itemType isEqualToString:@"2"]){
        if (isApplePad){
            return 160;
        }
        return 100;
    }else{
        return 0.000000001;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000000000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000000001;
}


#pragma - mark  删除操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除操作
         RollModel *model = self.dataArray[indexPath.row];
        
        [DatabaseTool deleteRollCollect:model.itemId];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (IBAction)edit:(UIBarButtonItem *)sender {
//    NSString * title = self.tableView.isEditing ? @"编辑" : @"完成";
//    [self.rightBtn setTitle:title forState:UIControlStateNormal];

    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
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


@end
