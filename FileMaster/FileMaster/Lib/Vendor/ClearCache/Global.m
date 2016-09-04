//
//  Global.m
//  ClearCache
//
//  Created by LXJ on 15/7/20.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "Global.h"
#define fileManager [NSFileManager defaultManager]

@implementation Global

+(NSString *)getFileSize:(NSString *)path
{
    NSString *message = @"";
 
    long long bytes = 0;
    bytes = [self fileSizeAtPath:path];
    if(bytes < 1000)     // B
    {
        message = [NSString stringWithFormat:@"%lldB", bytes];
    }
    else if(bytes >= 1000 && bytes < 1024 * 1024) // KB
    {
        message = [NSString stringWithFormat:@"%.0fK", (double)bytes / 1024];
    }
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)   // MB
    {
        message = [NSString stringWithFormat:@"%.1fM", (double)bytes / (1024 * 1024)];
    }
    else    // GB
    {
        message = [NSString stringWithFormat:@"%.1fG", (double)bytes / (1024 * 1024 * 1024)];
    }
 
    return message;
}

//计算缓存大小
+ (NSString*)cathSize
{
    NSString *path = [self getFilePathWithCache];
    NSFileManager* manager = [NSFileManager defaultManager];
    
    NSString *message;
    if ([manager fileExistsAtPath:path])
    {
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
        NSString* fileName;
        long long bytes = 0;
        while ((fileName = [childFilesEnumerator nextObject]) != nil)
        {
            NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            bytes += [self fileSizeAtPath:fileAbsolutePath];
        }
        
        if(bytes < 1000)     // B
        {
            message = [NSString stringWithFormat:@"%lldB", bytes];
        }
        else if(bytes >= 1000 && bytes < 1024 * 1024) // KB
        {
            message = [NSString stringWithFormat:@"%.0fK", (double)bytes / 1024];
        }
        else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)   // MB
        {
            message = [NSString stringWithFormat:@"%.1fM", (double)bytes / (1024 * 1024)];
        }
        else    // GB
        {
            message = [NSString stringWithFormat:@"%.1fG", (double)bytes / (1024 * 1024 * 1024)];
        }

    }
    return message;
}

+ (CGFloat)fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
//        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        NSDictionary *dict=   [fileManager attributesOfItemAtPath:filePath error:nil];
        
        float size=[dict[@"NSFileSize"] floatValue];
        return size;
    }
    return 0;
}

+ (void)clearCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager* manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:[self getFilePathWithCache]])
        {
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:[self getFilePathWithCache]] objectEnumerator];
            NSString* fileName;
            while ((fileName = [childFilesEnumerator nextObject]) != nil)
            {
                NSString* fileAbsolutePath = [[self getFilePathWithCache] stringByAppendingPathComponent:fileName];
                [manager removeItemAtPath:fileAbsolutePath error:nil];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self clearCacheSuccess];
            
        });

    });
}

+ (void)clearCacheSuccess {
    
    NSLog(@"清除缓存成功");
}

+ (NSString *)getFilePathWithCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end
