//
//  Rank_RootController.m
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Rank_RootController.h"
#import "RankDetailController.h"
#import "RankSort.h"
#import "RankCell.h"

@interface Rank_RootController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation Rank_RootController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    [[DBTools alloc]init];
//    [self.view addSubview:self.headerView];
//    self.headerView.frame = CGRectMake(0, 20, KWidth, 20);
//    self.headerView.backgroundColor = KRandomColor;
    
    self.tableView.frame =  CGRectMake(0, 0, KWidth, KHeight-44);
    
    self.tableView.rowHeight = 50;
    [self.tableView reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankCell *cell = [RankCell cellWithTableView:tableView];
    RankSort *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RankSort *model = self.dataArray[indexPath.row];
    
    RankDetailController *detailVc = [[RankDetailController alloc]init];
    detailVc.year = model.rank_year;
    detailVc.title = [NSString stringWithFormat:@"%@",model.rank_year];//@"";
    [self.navigationController pushViewController:detailVc animated:YES];
}



-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:[DBTools get_rank_sorts]];
    }
    return _dataArray;
}


@end
