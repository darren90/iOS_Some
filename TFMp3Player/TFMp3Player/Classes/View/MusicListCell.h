//
//  MusicListCell.h
//  TFMp3Player
//
//  Created by Tengfei on 16/5/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;
@interface MusicListCell : UITableViewCell
@property (nonatomic, strong) MusicModel *music;

+ (instancetype)musicCellWithTableView:(UITableView *)tableView;
@end
