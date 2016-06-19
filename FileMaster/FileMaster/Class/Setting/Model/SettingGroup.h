//
//  SettingGroup.h
//  FileMaster
//
//  Created by Tengfei on 16/6/19.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *header;
/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footer;
/**
 *  存放着这组所有行的模型数据(这个数组中都是SettingModel对象)
 */
@property (nonatomic, copy) NSArray *items;


@end
