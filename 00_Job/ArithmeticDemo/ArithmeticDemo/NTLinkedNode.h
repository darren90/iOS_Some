//
//  NTLinkedNode.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTLinkedNode : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NTLinkedNode *prev;
@property (nonatomic, strong) NTLinkedNode *next;

@end
