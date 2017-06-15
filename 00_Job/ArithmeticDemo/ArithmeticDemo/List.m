//
//  List.m
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "List.h"

@implementation List
- (instancetype)init{
    if (self = [super init]) {//初始化链表
//        self.va
        self->_value = 0;
        self->_next = nil;
    }
    
    return self;
}
+ (instancetype)createLikedList {//创建链表
    List *L = [[List alloc] init];
    return  L;
}
-(void)insertBeforeList:(List *)Node inserbefore: (List *)NewNode{//向前插入节点
    List *CosorNode = self;
    while (CosorNode.next != nil) {
        if (CosorNode.next.value == Node.value) {//根据节点的value进行查询
            NewNode.next = CosorNode.next;
            CosorNode.next = NewNode;
            break;
        }else {
            CosorNode = CosorNode.next;
        }
        
    }
}
-(void)insertAfterList:(List *)NewNode{//向后插入节点
    List *CosorNode = self;
    while (CosorNode.next != nil) {
        CosorNode = CosorNode.next;
        
    }
    CosorNode.next =NewNode;
    NewNode.next = nil;
    
}
-(void)deleteList:(List *)Node{//删除节点
    List *CosorNode = self;
    while (CosorNode.next!=nil) {
        if (CosorNode.next.value == Node.value) {
            CosorNode.next = Node.next;
            break;
        }else{
            CosorNode = CosorNode.next;
        }
    }
}
-(List *)searchList:(int)values{//查找节点
    List *CosorNode = self;
    while (CosorNode.next!=nil) {
        if (CosorNode.next.value == values) {
            return CosorNode.next;
            break;
        }else{
            CosorNode = CosorNode.next;
        }
        
    }
    return nil;
}

//反转链表

-(void)reverseList2:(List *)list {
    if (list == nil || list.next == nil) {
        return;
    }
    
    List *left = nil;
    List *right = list;
    while (right) {
        list = right.next;
        right.next = left;
        left = right;
         = next;
    }
}

-(List *)reverseList:(List *)list {
    if(list == nil || list.next == nil) {
        return list;
    }
    
    List *new = [self reverseList:list.next];
    
    
    return new;
}




@end
