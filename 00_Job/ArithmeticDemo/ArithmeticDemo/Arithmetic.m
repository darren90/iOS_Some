//
//  Arithmetic.m
//  ArithmeticDemo
//
//  Created by Fengtf on 2017/3/14.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Arithmetic.h"
#import "Person.h"

@implementation Arithmetic

-(instancetype)init{

    if (self = [super init]) {
        
        NSMutableArray *mutabArr = [NSMutableArray arrayWithObjects:@15,@13,@100,@6,@89,@2, nil];
        [self bubbleSort:mutabArr];
        [self insertionSort:mutabArr];
        NSLog(@"---排序后 :%@",mutabArr);
        
        [self swapTwo];
        
        [self addBigIntA:@"3878782433421298" b:@"9777766234234234234237898"];

        [self lengthOfLongestSubstring:@"abcabcbb"];

        [self findNum];

        NSArray *arr = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"6",@"7", nil];
        [self queryNumber:arr value:6];

        [self arrayRemoveDupl];
        
        
        
        Person *p = [[Person alloc] init];
//        [self addObserver:p forKeyPath:@"name" options:NSKeyValueObservingOptionNew context: nil];
//        [p setValue:@[@"23", @"23"]forKey:@"_name"];
//        NSLog(@"%@",p.name);
    }
    return  self;
}


#pragma mark --- 数组去重
-(void)arrayRemoveDupl{
    NSArray *array = @[@"12-11", @"12-11", @"12-11", @"12-12", @"12-13", @"12-14"];
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:array];
    NSLog(@"%@", set.array);
}

#pragma mark -- 消除括号
/**
    给定一个如下的字符串(1,(2,3),(4,(5,6)7))括号内的元素可以是数字，也可以是括号，请实现一个算法清除嵌套的括号，比如把上面的表达式的变成：(1,2,3,4,5,6,7)，表达式有误时请报错。
 */
-(void)removeBraces{
    NSString *str = @"(1,(2,3),(4,(5,6)7))";


}



#pragma mark -- 二维有序数组查找数字
/**
    二维数组的的二分查找
 */

-(void)findNum{
    int searchNum = 16;

    NSArray *a1 = @[@1,@3,@5,@7];
    NSArray *a2 = @[@10,@11,@16,@20];
    NSArray *a3 = @[@23,@32,@39,@50];


    NSArray *arr = @[a1,a2,a3];

    int left = 0;
    int right = (int)arr.count;
    BOOL firstRetult = NO ;
    while (left <= right) {
        int middle = (left + right) / 2;

        NSArray *rowArr = arr[middle];
        int rowArrLast = [rowArr.lastObject intValue];
        if (rowArrLast < searchNum) {
            left = middle + 1;
        }else if (rowArrLast > searchNum){
            right = middle - 1;
        }else{
            firstRetult = YES;
            NSLog(@"--结果：%d-%lu",middle,arr.count - 1);
            break;
        }
    }

    if (firstRetult) {
        return;
    }
    NSLog(@"第一层----left:%d,right:%d",left,right);

    NSArray *targetArr = arr[left];
    int tartgetLeft = 0;
    int tartgetRight = (int)targetArr.count;
    BOOL secondResult = NO ;
    while (tartgetLeft <= tartgetRight) {
        int tartgetMiddle = (tartgetLeft + tartgetRight) / 2 ;

        int targetInt = [targetArr[tartgetMiddle] intValue];
        if (targetInt < searchNum) {
            tartgetLeft = tartgetMiddle + 1;
        }else if (targetInt > searchNum){
            tartgetRight = tartgetMiddle - 1;
        }else{
            secondResult = YES;
            NSLog(@"结果：%d-%d",left,tartgetMiddle);
            break;
        }
    }

    if (secondResult == NO) {
        NSLog(@"没有结果，最接近的结果是：%d-%d",left,tartgetLeft);
    }
}

#pragma mark --- 二分查找
- (void)queryNumber:(NSArray*)arr value:(int)inter

{

    NSInteger left = 0;

    NSInteger right = arr.count;

    while (left <= right) {

        NSInteger mid = (left + right) / 2;

        if ([[arr objectAtIndex:mid] intValue]<  inter)  {
            left = mid+1;
        }  else if ([[arr objectAtIndex:mid] intValue] > inter)  {
            right = mid - 1;
        }  else {
            NSLog(@"所查询的数为%d",[[arr objectAtIndex:mid] intValue]);
            break;
        }
    }
    
}





-(void)findNumTemp{
    const int rows = 3;
    const int cols = 4;
    int array[rows][cols] = {{1, 3, 5, 7}, {10, 11, 16, 20}, {23, 30, 34, 50}};
    int searchNum = 34;
    // 是否查找成功
    int found = 0;

    // 查找第一行最后一个元素
    for (int i = 0; i < rows; ++i) {
        int last = array[i][cols - 1];

        if (last == searchNum) {
            NSLog(@"找到了，位置为：(%d, %d)", i, cols - 1);
            break;
        }
        // 说明待查找的元素就在这一行，或者根本不存在
        else if (last > searchNum) {
            int mid = 0;
            int low = 0;
            int high = cols - 1;

            while (low <= high) {
                mid = (low + high) / 2;

                if (array[i][mid] == searchNum) {
                    found = YES;
                    NSLog(@"找到了，位置为：(%d, %d)", i, cols - 1);
                    return;
                } else if (array[i][mid] > searchNum) {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            
            if (!found) {
                NSLog(@"查找失败了，元素并不在二维数组中");
            }
        }
    }
}


/**
    LeetCode：
    Given a string, find the length of the longest substring without repeating characters. For example, the longest substring without repeating letters for "abcabcbb" is "abc", which the length is 3. For "bbbbb" the longest substring is "b", with the length of 1.
 
 思路：
     1.若给定字符串为空，返回0（注意边界情况）；否则转2。

     2.用tempString来存储无重复子串,maxSize来记录最长无重复子串的长度；

     初始化tempString为给定字符串的第一个字符，maxSize=1；

     从字符串的第2个字符开始，到字符串结束，依次检测每一个字符是否出现在当前无重复子串中：

     （1） 若这个字符在没有出现在当前无重复子串中，将该字符加入到当前无重复子串中；

     （2）若这个字符出现在了当前无重复子串中，

     比较该无重复子串的长度与maxSize的大小，若该无重复子串的长度大于maxSize，更新maxSize为该无重复子串的长度；

     更新tempString为字符串中出现当前字符的下一个字符起始到该字符为止的子串（这里说的比较绕口，或不好懂，可以看代码）；

     3.待整个字符串都检测完毕后，最后判断一次tempString的长度与maxSize的大小，返回较大的一个。
 */
#pragma mark --- 最长无重复子串
-(NSString *)lengthOfLongestSubstring:(NSString *)originStr{
    NSUInteger length = originStr.length;
    if (length == 0) {
        NSLog(@"最长无重复子串-长度为0");
        return @"";
    }

    NSString *resultStr = @"";
//    NSUInteger subLength = 0;

    for(int i = 0;i < length ; i++){
        NSRange range = NSMakeRange(i, 1);
        NSString *sub = [originStr substringWithRange:range];
        if ([resultStr rangeOfString:sub].location == NSNotFound) {
            resultStr = [resultStr stringByAppendingString:sub];
        }
    }

    NSLog(@"%@：的最长无重复子串为：%@",originStr,resultStr);
    return resultStr;
}




#pragma mark --- 大数相加
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

    NSString *sumInt = @"";
    int carryInt = 0;
    for (int i = 0 ; i< invertA.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subA = [invertA substringWithRange:range];
        NSString *subB = [invertB substringWithRange:range];
        
        int intA = [subA intValue];
        int intB = [subB intValue];
        int result = intA + intB + carryInt;

        if (result > 10) {
            carryInt = result / 10;
            int geweiInt = result % 10;
            sumInt = [sumInt stringByAppendingString:[NSString stringWithFormat:@"%d",geweiInt]];
            if(i == invertA.length - 1){
                sumInt = [sumInt stringByAppendingString:[NSString stringWithFormat:@"%d",carryInt]];
            }
        }else{
            carryInt = 0;
            sumInt = [sumInt stringByAppendingString:[NSString stringWithFormat:@"%d",result]];
        }
     }

    NSLog(@"--大数相加的结果：%@",sumInt);

    //再次反转
    sumInt = [self invertString:sumInt];

    return sumInt;
}


#pragma mark --- 字符串反转
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
    for(i = 0; i< [array count]-1; i++) {
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
    for (i = 1; i < list.count && bFinish; i++) {
        bFinish = NO; //每次遍历时，重置标志
        //从最后一位开始，依次跟前一位相比，如果较小，则交换位置
        //当一次遍历没有任何数据交换时，则说明已经排序完成(bFinish=YES)，则不再进行循环
        for (y = (int)list.count - 1; y >= i; y--) {
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
