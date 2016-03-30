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

@interface Home_RootController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation Home_RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 120;
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
    HomeRollCell *cell = [HomeRollCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
