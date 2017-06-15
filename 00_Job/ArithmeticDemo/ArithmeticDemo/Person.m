//
//  Person.m
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/13.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)share{
    static id p;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (p == nil) {
            p = [[Person alloc] init];
        }
    });
    
    return p;
}

- (void)setName:(NSString *)name{
    _name = name;
    
    NSLog(@"-nmae-:%@",name);
}


@end
