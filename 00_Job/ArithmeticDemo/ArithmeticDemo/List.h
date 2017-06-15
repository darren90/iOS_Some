//
//  List.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject
@property NSInteger value;//节点整形成员
@property List *next;//节点指针型成员
//create
- (instancetype)init;//初始化链表
+(instancetype)createLikedList;//创建链表
-(void)insertBeforeList:(List *)Node inserbefore: (List *)NewNode;//在节点前插入节点
-(void)insertAfterList:(List *)NewNode;//在节点后插入节点
-(void)deleteList:(List *)Node;//删除节点
-(List *)searchList:(int)values;//查询节点

@end
