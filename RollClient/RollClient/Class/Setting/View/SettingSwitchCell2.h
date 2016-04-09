//
//  SettingSwitchCell2.h
//  RollClient
//
//  Created by Tengfei on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingSwitchItem;
@interface SettingSwitchCell2 : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)SettingSwitchItem * item;


@end
