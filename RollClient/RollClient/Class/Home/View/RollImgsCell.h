//
//  RollImgsCell.h
//  RollClient
//
//  Created by Tengfei on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RollModel;
@interface RollImgsCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)RollModel *model;

@end
