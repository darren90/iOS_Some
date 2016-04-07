//
//  DatabaseTool.h
//  Diancai1
//
//  Created by user on 14+3+11.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  RollModel;
@interface DatabaseTool : NSObject

////缓存////////////////////
 //+ (void)saveRollList:(NSDictionary *)dictionary withId:(NSString *)idStr;
+ (void)saveRollListW:(RollModel *)model withId:(NSString *)idStr;
+ (void)deleteRollListWith:(NSString*)idStr;
+ (NSMutableArray *)getRollList;


////收藏////////////////////
+(BOOL)isHadCollected:(NSString *)idStr;

+ (void)saveRollCollect:(RollModel *)model withId:(NSString *)idStr;

+ (void)deleteRollCollect:(NSString*)idStr;

+ (NSMutableArray *)getRollCollects;

@end
















