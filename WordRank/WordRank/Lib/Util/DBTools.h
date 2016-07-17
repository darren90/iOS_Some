//
//  DBTools.h
//  FileMaster
//
//  Created by Tengfei on 16/6/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTools : NSObject

+(NSArray *)get_rank_word_year:(NSString *)rank_year;

+(void)saveSeekDuration:(NSString *)title duration:(double)duration;

@end
