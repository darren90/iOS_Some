//
//  Global.h
//  ClearCache
//
//  Created by LXJ on 15/7/20.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

+ (NSString*)cathSize;

+(NSString *)getFileSize:(NSString *)path;

+ (void)clearCache;

+ (NSString *)getFilePathWithCache;

@end
