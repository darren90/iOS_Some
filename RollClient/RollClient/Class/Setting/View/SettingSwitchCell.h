//
//  SettingSwitchCell.h
//  MovieBinge
//
//  Created by Fengtf on 16/1/7.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingSwitchItem;
@interface SettingSwitchCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)SettingSwitchItem * item;


@end
