//
//  SettingArrowItem.m
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    SettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
//---

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title identifier:(NSString *)identifier
{
    SettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.identifier = identifier;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title identifier:(NSString *)identifier
{
    return [self itemWithIcon:nil title:title identifier:identifier];
}
@end
