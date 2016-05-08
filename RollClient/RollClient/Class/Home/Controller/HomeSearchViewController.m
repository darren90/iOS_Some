//
//  HomeSearchViewController.m
//  RollClient
//
//  Created by Tengfei on 16/5/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "RollModel.h"
#import "HomeRollCell.h"
#import "RollVideoCell.h"
#import "RollImgsCell.h"
#import "HomeDetailViewController.h"

@interface HomeSearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)DownClick:(UIBarButtonItem *)sender;

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,assign)BOOL isRefreshing;
@property (nonatomic,assign)int currentPage;
@property (nonatomic, weak) UIImageView *noDataView;

@end

@implementation HomeSearchViewController

//查看详情后，再次进入主界面，刷新，显示为灰色字体
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    [self.dataArray removeAllObjects];
    [self getData];
}

-(void)getData{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!self.searchText) {
        self.searchText = @"";
    }
    params[@"itemTitle"] = self.searchText;
    params[@"pageNumber"] = [NSString stringWithFormat:@"%d",self.currentPage];
 
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    mgr.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送请求
    __unsafe_unretained __typeof(self) weakSelf = self;
    [mgr POST:@"http://112.74.95.46/item/query" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {//responseObject 字典
          [weakSelf stopRefresh];
         NSLog(@"%@",responseObject[@"result"]);
          
          NSArray *array = [RollModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
          
          //缓存数据
          for (RollModel *m in array) {
              [DatabaseTool saveRollListW:m withId:m.itemId];
          }
          
          [self.dataArray addObjectsFromArray:array];
//          self.noDataView.hidden = (self.dataArray.count != 0);
          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@",error);
          [self.dataArray addObjectsFromArray:[DatabaseTool getRollList]];
          [self.tableView reloadData];
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
    detail.collectModel = model;
    [self.fatherVC.navigationController pushViewController:detail animated:YES];
    
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


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (IBAction)DownClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)noDataView
{
    if (!_noDataView) {
        // 添加一个"没有数据"的提醒
        UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodata_image"]];
        [self.view addSubview:noDataView];
        [noDataView autoCenterInSuperview];
        self.noDataView = noDataView;
        [self.view bringSubviewToFront:noDataView];
    }
    return _noDataView;
}


@end
