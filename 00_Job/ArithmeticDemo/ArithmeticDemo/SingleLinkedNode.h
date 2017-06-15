//
//  SingleLinkedNode.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleLinkedNode : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) SingleLinkedNode *next;


@end
