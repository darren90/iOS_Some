//
//  NTLinkedMap.h
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/15.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTLinkedNode.h"

@interface NTLinkedMap : NSObject

- (void)addNodeAtHead:(NTLinkedNode *)node;
- (void)addNode:(NTLinkedNode *)newNode beforeNodeForKey:(NSString *)key;
- (void)addNode:(NTLinkedNode *)newNode behindNodeForKey:(NSString *)key;
- (void)bringNodeToHead:(NTLinkedNode *)node;

- (void)readAllNode;
- (void)removeNodeForKey:(NSString *)key;
- (NTLinkedNode *)removeTailNode;

- (void)headNode;
- (void)tailNode;

@end
