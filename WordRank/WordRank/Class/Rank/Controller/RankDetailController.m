//
//  RankDetailController.m
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RankDetailController.h"
#import "Rank_Word.h"
#import "Rank_Word_HeaderView.h"
#import "RankDetailCell.h"

@interface RankDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * dataArray;



@property (nonatomic,strong)Rank_Word_HeaderView * headerView;


@end

@implementation RankDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[DBTools alloc]init];
    [self.view addSubview:self.headerView];
    self.headerView.frame = CGRectMake(0, 20, KWidth, 20);
    self.headerView.backgroundColor = KRandomColor;
    
    self.tableView.frame =  CGRectMake(0, CGRectGetMaxY(self.headerView.frame), KWidth, KHeight-CGRectGetMaxY(self.headerView.frame)-44);

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
    RankDetailCell *cell = [RankDetailCell cellWithTableView:tableView];
    Rank_Word *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}



-(Rank_Word_HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [Rank_Word_HeaderView headerView];
    }
    return _headerView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:[DBTools get_rank_word_year:self.year]];
    }
    return _dataArray;
}

@end
