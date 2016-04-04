//
//  SettingArrowItem.h
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingItem.h"

@interface SettingArrowItem : SettingItem
@property (assign, nonatomic) Class destVcClass;

/**
 *  StoryBoard ID
 */
@property (nonatomic,copy)NSString * identifier;



+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;



+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title identifier:(NSString *)identifier;
+ (instancetype)itemWithTitle:(NSString *)title identifier:(NSString *)identifier;
@end
