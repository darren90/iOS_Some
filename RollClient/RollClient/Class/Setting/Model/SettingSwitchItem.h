//
//  SettingSwitchItem.h
//  MovieBinge
//
//  Created by Fengtf on 16/1/7.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "SettingItem.h"

@interface SettingSwitchItem : SettingItem

/**
 *  是否打开了开关
 */
@property (nonatomic,assign)BOOL isOn;


+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle isOn:(BOOL)isOn;
@end
