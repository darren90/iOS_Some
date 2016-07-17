//
//  DBTools.h
//  FileMaster
//
//  Created by Tengfei on 16/6/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTools : NSObject

+(double)getSeekDuration:(NSString *)title;

+(void)saveSeekDuration:(NSString *)title duration:(double)duration;

@end
