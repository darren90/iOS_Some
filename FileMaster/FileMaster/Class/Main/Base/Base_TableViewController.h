//
//  Base_TableViewController.h
//  FileMaster
//
//  Created by Tengfei on 16/6/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface Base_TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)UITableView * tableView;

@property (nonatomic, weak) UIImageView *noDataView;


@end
