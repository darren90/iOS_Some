//
//  Queue.m
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Queue.h"

@implementation Queue
-(instancetype)init{//初始化头结点
    if (self = [super init]) {
        self->_value = 0;
        self->_next = nil;
    }
    return  self;
}
+(instancetype)createWithQueue{
    Queue *q = [[Queue alloc] init];//创建队列
    return  q;
}
-(void)enqueue:(Queue *)Node {//入队
    Queue *q = self;
    while (q.next!=nil) {//循环找到队列的最后一个节点（指向nil）。
        q = q.next;
    }
    q.next = Node;//将尾节点指向入队节点
    Node.next = nil;
    
}
-(instancetype)outqueue{//出队
    Queue *q1;//作为转换的中间节点
    Queue *q = self;
    if (q.next==nil) {//如果队列只有一个则返回本身
        return q;
    }else{//否则取头结点后面的第一个节点作为返回值
        q1 = q.next;
        q.next = q.next.next;
        return q1;
    }
}

@end
