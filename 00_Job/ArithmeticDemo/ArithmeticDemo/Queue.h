//
//  Queue.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
@property NSInteger value;
@property Queue *next;
-(instancetype)init;
+(instancetype)createWithQueue;
-(void)enqueue:(Queue *)Node;
-(instancetype)outqueue;
@end
