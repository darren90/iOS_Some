//
//  main.m
//  ArithmeticDemo
//
//  Created by Fengtf on 2017/3/14.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Arithmetic.h"
#import "BinaryTreeNodeTest.h"
#import "BinaryTreeNode.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {


        Arithmetic *ari = [[Arithmetic alloc]init];
        BinaryTreeNodeTest *test = [[BinaryTreeNodeTest alloc]init];

        NSMutableArray *mutabArr = [NSMutableArray arrayWithObjects:@15,@13,@100,@6,@89,@2, nil];

        BinaryTreeNode *node = [BinaryTreeNode createTreeWithValues:mutabArr];
        NSLog(@"%@",node);
    }
    return 0;
}


