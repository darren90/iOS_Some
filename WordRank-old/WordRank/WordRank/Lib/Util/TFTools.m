//
//  TFTools.m
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFTools.h"

@implementation TFTools


+(BOOL)shouldExecuteSql
{
    BOOL version_1 = [self isVersion_1_0];
    
    //取出沙盒中存储的上一次使用的版本号
    NSString *key = @"ExecuteSql";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isHadExecute = [defaults stringForKey:key];
    if (!isHadExecute && version_1) {
        //存储新版本
        [defaults setObject:@YES forKey:key];
        [defaults synchronize];
        
        return YES;
    }else{
        return NO;
    }
}




//是否 仍绕是2.0版本 小于3.0的的版本
+ (BOOL)isVersion_1_0{
    NSString * key = @"CFBundleShortVersionString";//version
    NSString *currenVersion = [NSBundle mainBundle].infoDictionary[key];
    CGFloat version = [currenVersion floatValue];
    if (version == 1.0) {
        return YES;
    } else {
        return NO;
    }
}

@end
