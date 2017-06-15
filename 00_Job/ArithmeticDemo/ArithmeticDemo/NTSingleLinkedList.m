//
//  NTSingleLinkedList.m
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "NTSingleLinkedList.h"


@interface NTSingleLinkedList () {
    
    SingleLinkedNode *_headNode;
    NSMutableDictionary *dictKeyValue;
}

@end


@implementation NTSingleLinkedList



- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        dictKeyValue = [NSMutableDictionary dictionary];
    }
    
    return self;
}

//新节点添加在头部之前；
- (void)addNodeAtHead:(SingleLinkedNode *)node {
    
    dictKeyValue[node.key] = node;
    if (_headNode) {
        
        node.next = _headNode;
        _headNode = node;
        
    } else {
        
        _headNode = node;
    }
}


//新节点添加值指定节点之后（节点不可重复）；
- (SingleLinkedNode *)addNode:(SingleLinkedNode *)newNode behindNodeForKey:(NSString *)key {
    
    if (!key) {
        
        return _headNode;
    }
    
    SingleLinkedNode *node = dictKeyValue[key];
    if (dictKeyValue[newNode.key]) {//判断节点是否存在；
        
        return _headNode;
    }
    
    dictKeyValue[newNode.key] = newNode;
    newNode.next = node.next;
    node.next = newNode;
    
    
    return newNode;
}


//删除节点；
- (SingleLinkedNode *)removeNode:(SingleLinkedNode *)node {
    
    if (!_headNode || !node) {
        
        return _headNode;
    }
    
    SingleLinkedNode *tempNode;
    [dictKeyValue removeObjectForKey:node.key];
    
    //若删除节点不是尾节点，则将当前节点替换成当前节点的下一个节点；
    if (node.next) {
        
        tempNode = node.next;
        node.next = node.next.next;
        node.key = tempNode.key;
        node.value = tempNode.value;
        
        tempNode = nil;
        return _headNode;
        
    } else {
        
        //从_headNode开始遍历链表，找到tempNode即node的前一个节点；
        tempNode = _headNode;
        while (tempNode.next && ![tempNode.next isEqual:node]) {
            
            tempNode = tempNode.next;
        }
        
        if (tempNode.next) {
            
            tempNode.next = node.next;
        }
    }
    
    return _headNode;
}


//将node移至头部head；
- (void)bringNodeToHead:(SingleLinkedNode *)node {
    
    if (!_headNode || !node) {
        
        return;
    }
    
    if ([_headNode isEqual:node]) {
        
        return ;
    }
    
    //从_headNode开始遍历链表，找到tempNode即node的前一个节点；
    SingleLinkedNode *tempNode = _headNode;
    while (tempNode.next && ![tempNode.next isEqual:node]) {
        
        tempNode = tempNode.next;
    }
    
    if (tempNode.next) {
        
        tempNode.next = node.next;
    }
    
    node.next = _headNode;
    _headNode = node;
}


//查找单向列表中的一个节点；
- (SingleLinkedNode *)selectNode:(NSString *)key {
    
    //当然了，因为定义了字典dicKeyVaue，可以通过此字典，直接返回对应key的node；
    //return dicKeyVaue[key];
    
    SingleLinkedNode *tempNode = _headNode;
    while (tempNode) {
        
        if ([tempNode.key isEqualToString:key]) {
            
            return tempNode;
        }
        
        tempNode = tempNode.next;
    }
    
    return _headNode;
}


//遍历所有节点；
- (void)readAllNode {
    
    SingleLinkedNode *tempNode = _headNode;
    while (tempNode) {
        
        NSLog(@"node key -- %@, node value -- %@", tempNode.key, tempNode.value);
        tempNode = tempNode.next;
    }
}
@end
