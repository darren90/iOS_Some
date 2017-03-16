//
//  BinaryTreeNode.m
//  ArithmeticDemo
//
//  Created by Fengtf on 2017/3/14.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *
 *  @param values 数组
 *
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values {

    BinaryTreeNode *root = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [self addTreeNode:root value:value];
    }
    return root;
}

/**
 *  向二叉排序树节点添加一个节点
 *
 *  @param treeNode 根节点
 *  @param value    值
 *
 *  @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }else if (value <= treeNode.value) {
        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [self addTreeNode:treeNode.leftNode value:value];
    }else {
        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [self addTreeNode:treeNode.rightNode value:value];
    }

    return treeNode;
}


#pragma mark --- 反转二叉树
// 主要是考查了递归的思想
// 参考： http://wzdark.github.io/personalInfo/2015/08/03/invertBinaryTree.html
// 参考： http://www.cnblogs.com/manji/p/4903990.html
-(BinaryTreeNode *)invertTree:(BinaryTreeNode *)root{
    if(root == nil){
        return nil;
    }

    root.leftNode = [self invertTree:root.leftNode];
    root.rightNode = [self invertTree:root.rightNode];

    BinaryTreeNode *temp = root.leftNode;
    root.leftNode = root.rightNode;
    root.rightNode = temp;

    return root;
}



















@end
