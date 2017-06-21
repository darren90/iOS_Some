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
#import "SortTest.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {


        Arithmetic *ari = [[Arithmetic alloc]init];
        BinaryTreeNodeTest *test = [[BinaryTreeNodeTest alloc]init];

        NSMutableArray *mutabArr = [NSMutableArray arrayWithObjects:@15,@13,@100,@6,@89,@2, nil];

        BinaryTreeNode *node = [BinaryTreeNode createTreeWithValues:mutabArr];
        NSLog(@"%@",node);
        
        
        int result = add(100);
        NSLog(@"--add100 : %d",result);
        
        
        SortTest *sort = [[SortTest alloc] init];
        [sort run];
    }
    return 0;
}


int add(int n){
    return n == 0 ? 0 : n + add(n-1);
}




