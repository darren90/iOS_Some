//
//  HomeRollCell.h
//  RollClient
//
//  Created by Fengtf on 16/3/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RollModel;
@interface HomeRollCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)RollModel *model;


@end
