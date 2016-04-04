//
//  SettingItem.h
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject
/**
 *  操作
 */
typedef void(^SettingItemOperation)();

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
//@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, copy) SettingItemOperation operation;



+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;

@end
