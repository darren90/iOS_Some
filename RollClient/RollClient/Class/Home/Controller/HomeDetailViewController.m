//
//  HomeDetailViewController.m
//  RollClient
//
//  Created by Fengtf on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)getData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"itemId"] = self.itemId;
    
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    mgr.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送请求 http://112.74.95.46/item/n/video
    [mgr POST:@"http://112.74.95.46/item/n/detail" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {//responseObject 字典
          NSLog(@"%@",responseObject[@"result"]);
//          NSArray *array = [RollModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
//          NSLog(@"----------------------");
//          [self.dataArray addObjectsFromArray:array];
//          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
      }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
