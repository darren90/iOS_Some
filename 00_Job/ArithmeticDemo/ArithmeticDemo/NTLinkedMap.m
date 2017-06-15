//
//  NTLinkedMap.m
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "NTLinkedMap.h"
#import "NTLinkedNode.h"

@interface NTLinkedMap () {
    
    NTLinkedNode *_headNode;//头节点；
    NTLinkedNode *_tailNode;//尾节点；
    NSMutableDictionary *dicKeyValue;//用于保存所有节点；
}

@end

@implementation NTLinkedMap

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        dicKeyValue = [NSMutableDictionary dictionary];
    }
    
    return self;
}

//将节点添加在头部之前；
- (void)addNodeAtHead:(NTLinkedNode *)node {
    
    dicKeyValue[node.key] = node;
    if (_headNode) {
        
        node.next = _headNode;
        _headNode.prev = node;
        _headNode = node;
        
    } else {
        
        _headNode = _tailNode = node;
    }
}

//在指定的节点之前添加新节点；
- (void)addNode:(NTLinkedNode *)newNode beforeNodeForKey:(NSString *)key {
    
    NTLinkedNode *node = dicKeyValue[key];
    dicKeyValue[newNode.key] = newNode;
    
    if (!_headNode && !_tailNode) {
        
        _headNode = _tailNode = newNode;
    }
    
    if (node) {
        
        if ([_headNode isEqual:node]) {
            
            _headNode = newNode;
        }
        
        if (node.prev) {
            
            newNode.prev = node.prev;
            node.prev.next = newNode;
        }
        
        newNode.next = node;
        node.prev = newNode;
    }
}


//在指定的节点之后添加新节点；
- (void)addNode:(NTLinkedNode *)newNode behindNodeForKey:(NSString *)key {
    
    NTLinkedNode *node = dicKeyValue[key];
    dicKeyValue[newNode.key] = newNode;
    
    if (!_headNode && !_tailNode) {
        
        _headNode = _tailNode = newNode;
        
    } else {
        
        if (node) {
            
            if ([_tailNode isEqual:node]) {
                
                _tailNode = newNode;
            }
            
            if (node.next) {
                
                node.next.prev = newNode;
                newNode.next = node.next;
            }
            
            newNode.prev = node;
            node.next = newNode;
        }
    }
}


//移动node至头部节点；
- (void)bringNodeToHead:(NTLinkedNode *)node {
    
    if ([_headNode isEqual:node]) {
        
        return;
    }
    
    if ([_tailNode isEqual:node]) {
        
        _tailNode = node.prev;
        _tailNode.next = nil;
        
    } else {
        
        node.next.prev = node.prev;
        node.prev.next = node.next;
    }
    
    _headNode.prev = node;
    node.next = _headNode;
    node.prev = nil;
    _headNode = node;
}


//移除某个节点；
- (void)removeNodeForKey:(NSString *)key {
    
    NTLinkedNode *node = dicKeyValue[key];
    if (node) {
        
        [dicKeyValue removeObjectForKey:key];
        if (node.next) {
            
            node.next.prev = node.prev;
        }
        
        if (node.prev) {
            
            node.prev.next = node.next;
        }
        
        if ([_headNode isEqual:node]) {
            
            _headNode = node.next;
        }
        
        if ([_tailNode isEqual:node]) {
            
            _tailNode = node.prev;
        }
    }
}


//移除尾部节点；
- (NTLinkedNode *)removeTailNode {
    
    if (!_tailNode) {
        
        return nil;
    }
    
    NTLinkedNode *tailNode = _tailNode;
    [dicKeyValue removeObjectForKey:_tailNode.key];
    if (_headNode == _tailNode) {
        
        _headNode = _tailNode = nil;
        
    } else {
        
        _tailNode = _tailNode.prev;
        _tailNode.next = nil;
    }
    
    return tailNode;
}


//遍历所有的node节点；
- (void)readAllNode {
    
    if (_headNode) {
        
        NTLinkedNode *node = _headNode;
        while (node) {
            
            NSLog(@"key -- %@, value -- %@", node.key, node.value);
            node = node.next;
        }
    }
}

- (void)headNode {
    
    NSLog(@"head node key -- %@, head node value -- %@", _headNode.key, _headNode.value);
    NSLog(@"node count -- %lu", (unsigned long)dicKeyValue.count);
}

- (void)tailNode {
    
    NSLog(@"tail node key -- %@, tail node value -- %@", _tailNode.key, _tailNode.value);
    NSLog(@"node count -- %lu", (unsigned long)dicKeyValue.count);
}
@end
