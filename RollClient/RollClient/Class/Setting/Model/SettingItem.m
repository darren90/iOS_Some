//
//  SettingItem.m
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle
{
    SettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    item.subtitle = subtitle;
    return item;
}


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    return [self itemWithIcon:nil title:title subtitle:subtitle];
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}

@end
