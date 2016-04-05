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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tableView.rowHeight = 120;
   
    __weak __typeof (self) weakSelf = self;
    self.tableView.mj_header =  [MJRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        weakSelf.isRefreshing = YES;
        [weakSelf getData];
    }];

    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage ++;
        weakSelf.isRefreshing = NO;
        [weakSelf getData];
    }];
    [self getData];
}



-(void)getData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"itemTitle"] = @"";
    params[@"pageNumber"] = @"1";
    
    //    mgr.responseSerializer.acceptableContentTypes  = [NSSet setWithObject:@"application/json"];
    
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    mgr.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送请求
    [mgr POST:@"http://112.74.95.46/item/query" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {//responseObject 字典
          NSLog(@"%@",responseObject[@"result"]);
          NSArray *array = [RollModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
          NSLog(@"----------------------");
          [self.dataArray addObjectsFromArray:array];
          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
      }];
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


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
