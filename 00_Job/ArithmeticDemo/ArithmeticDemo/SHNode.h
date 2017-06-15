//
//  SHNode.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHNode : NSObject

@property SHNode *head;//链表的头，学懂了OC的类其实这个头可以省略，不过现在为了便于理解就写上了
@property SHNode *lastNode;//链表的当前的最后一个结点，因为链表采用的是尾插法，以前一直用的头插法这次换个写法
@property int data;//链表中要存的数据，可以自定义多个
@property SHNode *next;//指向下一个结点

-(void)append:(int)data;//插入结点的方法
-(void)print;//打印链表的方法
+(id)nodeList;//初始化链表的工厂方法，这里可以不用这个，只不过用了会方便一些，牵扯到设计模式就不多说了

@end
