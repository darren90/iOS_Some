//
//  ViewController.m
//  RollClient
//
//  Created by Tengfei on 16/3/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "AFURLRequestSerialization.h"
#import "RollModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
// http://112.74.95.46/item/query  post ，参数 itemTitle  pageNumber
    

    
//    [self getData];
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
          NSLog(@"%@",array);

      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
      }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
