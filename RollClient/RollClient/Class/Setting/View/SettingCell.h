//
//  SettingCell.h
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingItem;
@interface SettingCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)SettingItem * item;



@end
