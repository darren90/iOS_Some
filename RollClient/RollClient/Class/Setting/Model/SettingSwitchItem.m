//
//  SettingSwitchItem.m
//  MovieBinge
//
//  Created by Fengtf on 16/1/7.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "SettingSwitchItem.h"

@implementation SettingSwitchItem

+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle isOn:(BOOL)isOn
{
    SettingSwitchItem *item = [self itemWithTitle:title subtitle:subtitle];
    item.isOn = isOn;
    return  item;
}
@end
