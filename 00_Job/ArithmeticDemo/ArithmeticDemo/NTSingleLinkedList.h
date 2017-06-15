//
//  NTSingleLinkedList.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleLinkedNode.h"

@interface NTSingleLinkedList : NSObject


- (void)addNodeAtHead:(SingleLinkedNode *)node;
- (SingleLinkedNode *)addNode:(SingleLinkedNode *)newNode behindNodeForKey:(NSString *)key;

- (SingleLinkedNode *)removeNode:(SingleLinkedNode *)node;
- (SingleLinkedNode *)selectNode:(NSString *)key;
- (void)bringNodeToHead:(SingleLinkedNode *)node;

- (void)readAllNode;

@end
