//
//  RankCell.h
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RankSort;
@interface RankCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)RankSort * model;


@end
