//
//  Arithmetic.m
//  ArithmeticDemo
//
//  Created by Fengtf on 2017/3/14.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Arithmetic.h"

@implementation Arithmetic

-(instancetype)init{

    if (self = [super init]) {
        
        NSMutableArray *mutabArr = [NSMutableArray arrayWithObjects:@15,@13,@100,@6,@89,@2, nil];
        //    [self bubbleSort:mutabArr];
        [self insertionSort:mutabArr];
        NSLog(@"---排序后 :%@",mutabArr);
        
        [self swapTwo];
        
        [self addBigIntA:@"213" b:@"3"];
        
    }
    return  self;
}
   

-(NSString *)addBigIntA:(NSString *)a b:(NSString *)b{
    
    //反转 a b
    NSString *invertA = [self invertString:a];
    NSString *invertB = [self invertString:b];
    
    NSUInteger lengA = invertA.length;
    NSUInteger lengB = invertB.length;
    
    if (lengA > lengB) {
        for (int i = 0; i < lengA - lengB; i++) {
            invertB = [invertB stringByAppendingString:@"0"];
        }
    }else{
        for (int i = 0; i < lengB - lengA; i++) {
            invertA = [invertA stringByAppendingString:@"0"];
        }
    }

    NSLog(@"a=:%@,b=:%@",invertA,invertB);
    
    NSString *result = @"";
    int carryInt = 0;
    for (int i = 0 ; invertA.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subA = [invertA substringWithRange:range];
        NSString *subB = [invertB substringWithRange:range];
        
        int intA = [subA intValue];
        int intB = [subB intValue];
        int result = intA + intB;
        
        if (result > 10) {
            
        }
     }
    
    
    return @"";
}
  
-(NSString *)invertString:(NSString *)str{
    NSString *invertA = @"";
    for(int i = (int)str.length - 1 ; i >= 0 ; i--){
        NSRange range = NSMakeRange(i, 1);
        NSString *sub = [str substringWithRange:range];
        invertA = [invertA stringByAppendingString:sub];
    }
//    NSLog(@"invertA:%@",invertA);
    return invertA;
}
    
    
    
#pragma mark --- 不用临时变量怎么实现swap(a, b) 
- (void)swapTwo{
        int a = 10;
        int b = 5;
        
        a=a+b;
        b=a-b;
        a=a-b;
        NSLog(@"a=:%d,b=:%d",a,b);
}


/**
 *  直接插入排序
 *  把待排序的纪录按其关键码值的大小逐个插入到一个已经排好序的有序序列中，直到所有的纪录插入完为止
 *
 */
-(void)insertionSort:(NSMutableArray*)array
{
    int i, y;
    for(i = 0; i< [array count]-1; i++)
    {
        //前面一位大于后面一位
        if([[array objectAtIndex:i+1]intValue] < [[array objectAtIndex:i]intValue]){
            //保存后面一位
            NSString *temp=[array objectAtIndex:i+1];
            //从后一位开始
            for(y=i+1; y>0 && [[array objectAtIndex:y-1] intValue] > [temp intValue]; y--){
                [array exchangeObjectAtIndex:y-1 withObjectAtIndex:y];
            }
        }
    }
}


/**
 *  冒泡排序
 *  对数组中每个位置的数据，从后往前推，依次比较相邻的两个数，如果后面的数较小，则交换两者位置
 *  如果一次遍历没有发生任何数据交换，则排序直接完成
 */
-(void)bubbleSort:(NSMutableArray *)list{
    if (list.count <= 1) {
        return;
    }
    int i, y;
    BOOL bFinish = YES; //是否发生数据交换
    for (i = 1; i<= [list count] && bFinish; i++) {
        bFinish = NO; //每次遍历时，重置标志
        //从最后一位开始，依次跟前一位相比，如果较小，则交换位置
        //当一次遍历没有任何数据交换时，则说明已经排序完成(bFinish=YES)，则不再进行循环
        for (y = (int)[list count]-1; y>=i; y--) {
            if ([[list objectAtIndex:y] intValue] > [[list objectAtIndex:y-1] intValue]) {
                //交换位置
                [list exchangeObjectAtIndex:y-1 withObjectAtIndex:y];
                NSLog(@"%d - %d - %@",i,y,list);
                bFinish = YES; //发生数据交换，则继续进行下一次遍历，直到未发生数据交换或者循环完成为止
            }

        }
    }
}

//#pragma mark -- 排序 - 直接插入
//-(void)insertSort:(NSMutableArray[NSNumber] *)arr{
//    for(int i = 0; i < arr.count; i++){
//        NSNumber *temp = arr[i];
//        for(int j = i-1; j >= 0 && arr[j] > temp ; j-- ){
//            arr[j+1] = arr[j];
//        }
//        arr[i+1] = temp;
//    }
//}


#pragma mark -- 二分查找
-(void)binarySearch{

}

#pragma mark -- 递归
-(int)recursion:(int)n{
    if (n == 1 || n == 0) {
        return 1;
    }
    return n * [self recursion:n-1];
}


#pragma mark -- 判断ip地址是否合法
-(void)checkIP:(NSString *)ipStr{
    if (ipStr.length == 0) {
        NSLog(@"不合法的ip");
        return;
    }

    NSArray *arr = [ipStr componentsSeparatedByString:@"."];
    int count = 0;
    for (NSString *subStr in arr) {
        NSString *string = [subStr stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]];
        if (string.length > 0){//非法字符串
            break;
        }
        int strInt = string.intValue;
        int zhengshu = strInt / 256;
        int result = strInt % 256;
        if (zhengshu == 0 && result >= 0 && result <= 255) {
            count ++;
        }
    }

    if (count == 4) {
        NSLog(@"合法iP");
    }else{
        NSLog(@"不合法ip");
    }
}

//最长公共子串
-(void)lcs:(NSString *)str1 str2:(NSString *)str2{

    for (int i = 0 ; i< 5 ; i++) {

    }

}

-(void)flip{
    NSString *str = @"iOS is Good Luachage";
    NSMutableString *result = [NSMutableString string];
    //    nsarr [str componentsSeparatedByString:@""];
    for (int i = str.length - 1; i >= 0 ; i--){
        NSRange range = NSMakeRange(i, 1);
        NSString *str2 = [str substringWithRange:range];
        //        let ss = str.
        [result appendString:str2];
    }
    NSLog(@"--result:%@",result);
}




@end
