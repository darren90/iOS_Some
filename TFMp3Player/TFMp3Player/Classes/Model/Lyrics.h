//
//  Lyrics.h
//  TFMp3Player
//
//  Created by Tengfei on 16/5/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lyrics : NSObject
/**
 *  时间点
 */
@property (nonatomic, copy) NSString *time;
/**
 *  词
 */
@property (nonatomic, copy) NSString *word;
/**
 *  返回所有的歌词model
 *
 */
+ (NSMutableArray *)lrcLinesWithFileName:(NSString *)fileName;

@end
