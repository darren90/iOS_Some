//
//  Home_RootController.m
//  RollClient
//
//  Created by Fengtf on 16/3/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Home_RootController.h"
#import "RollModel.h"
#import "HomeRollCell.h"
#import "RollVideoCell.h"
#import "RollImgsCell.h"
#import "HomeDetailViewController.h"

@interface Home_RootController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,assign)BOOL isRefreshing;

@property (nonatomic,assign)int currentPage;

@end

@implementation Home_RootController

//查看详情后，再次进入主界面，刷新，显示为灰色字体
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tableView.rowHeight = 120;

    self.currentPage = 1;
    __weak __typeof (self) weakSelf = self;
//    __unsafe_unretained __typeof(self) weakSelf = self;

    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        weakSelf.isRefreshing = YES;
        [weakSelf getData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        weakSelf.isRefreshing = NO;
        [weakSelf getData];
    }];
//    [self getData];
}



-(void)getData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"itemTitle"] = @"";
    params[@"pageNumber"] = [NSString stringWithFormat:@"%d",self.currentPage];
    
    //    mgr.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"application/json"];
    
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    mgr.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送请求
     __unsafe_unretained __typeof(self) weakSelf = self;
    [mgr POST:@"http://112.74.95.46/item/query" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {//responseObject 字典
          [weakSelf stopRefresh];
//          NSLog(@"%@",responseObject[@"result"]);
          NSArray *array = [RollModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
          NSLog(@"----------------------");
          [self.dataArray addObjectsFromArray:array];
          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
          weakSelf.currentPage --;
          [weakSelf stopRefresh];
      }];
}

-(void)stopRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 控制"没有数据"的提醒
    //    self.noDataView.hidden = (self.deals.count != 0);
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
        return 120;
    }else if ([model.itemType isEqualToString:@"2"]){
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


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
