//
//  SortTest.m
//  ArithmeticDemo
//
//  Created by Tengfei on 2017/6/20.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "SortTest.h"

@implementation SortTest

- (instancetype)init{
    if (self = [super init]) {
        [self test2];
        [self bubblingAction];
    }
    return self;
}


- (void)sort1{
    NSArray *array = [NSArray arrayWithObjects:@"abc",@"456",@"123",@"789",@"ef", nil];
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"排序后:%@",sortedArray);
}



#pragma mark -- 插入排序

//1.1直接插入（straight insertion sort）
/*
    算法思路：数组｛k1,k2,……，kn｝，排序一开始k1是一个有序序列，让k2插入得到一个表长为2的有序序列，依此类推，最后让kn插入上述表长为n－1的有序序列，得到表长为n的有序序列。
 */

- (void)straight {
    int a[]={98,97,34,345,33};
    int k=sizeof(a)/sizeof(a[0]);
    int j;
    for (int i=1; i<k; i++) {
        int temp=a[i];
        for (j=i-1; j>=0&&a[j]>temp; j--) {
            a[j+1]=a[j];
        }
        a[j+1]=temp;
    }

}

//1 、 选择排序算法
//插入排序的理解： 首先,找到数组中最小的那个元素 ,其次,将它和数组的第一个元素位置 (如果第一个元 就是最小元 那么它就和自己 )。再次,在剩下的元素中找到最小的元素, 将它与数组的第二个元素交换位置。如此反复, 到将整个数组排序。这种方法叫做做选择排序,因为它在不断地选择剩余元素之中的最小者。
//解析：对于长度为 N 的数组,选择排序需要大约 N^2/2 次比较和 N 次交换。
NSMutableArray *selectSort(NSMutableArray *array, int start) {
    if (start == array.count ) {
        return array;
    }
    
    int minNum = [array[start] intValue];
    int minIndex = start;
    for (int i = start ; i < array.count; i ++) {
        if (minNum > [array[i] intValue]) {
            minNum = [array[i] intValue];
            minIndex = i;
        }
    }
    
    [array exchangeObjectAtIndex:start withObjectAtIndex:minIndex];
    array = selectSort(array, start + 1);
    return array;
}

- (void)test2{
    NSArray *array = @[@(1), @(4), @(8), @(9), @(5), @(7), @(2)];
//    array = selectSort([array mutableCopy], 0);
    array = [self tf_selectSort:[array mutableCopy]];
    NSLog(@"%@",array);
}

- (NSArray *)tf_selectSort:(NSMutableArray *)array{
    if (array.count == 0) {
        return array;
    }
    
    int minNum = [array.firstObject intValue];
    int minIndex = 0;
    for (int i = 0; i < array.count; i++) {
        if (minNum > [array[i] intValue]) {
            [array exchangeObjectAtIndex:minIndex withObjectAtIndex:i];
            minNum = [array[i] intValue];
            minIndex = i;
//            continue;
        }
    }
    
    return array;
}



- (void)bubblingAction
{
    NSArray *array = @[@1,@23,@43,@5,@67,@89,@6,@3,@43,@11,@23,@22];
    NSMutableArray *bubbleArray = [NSMutableArray arrayWithArray:array];
//    [self bubbleSort:bubbleArray];
//    [self basicSelectedSort:bubbleArray];
    
    [self quickSortArray:bubbleArray withLeftIndex:0 andRightIndex:bubbleArray.count - 1];
    
    NSLog(@"%@",bubbleArray);

    NSLog(@"原数组array%@\n排序后的数组:%@",array,bubbleArray);
}
/*
 冒泡排序:
 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
 针对所有的元素重复以上的步骤，除了最后一个。
 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
 */
-(void)bubbleSort:(NSMutableArray *)array{
    for (int i = 0; i<= array.count-1; i++) {
        for (int y = 0; y < array.count - 1 - i; y++) {
            if ([array[y] intValue] > [array[y+1] intValue]) {
                [array exchangeObjectAtIndex:y+1 withObjectAtIndex:y];
            }
        }
    }
}

/*
 基本选择排序:
 对比数组中前一个元素跟后一个元素的大小，如果后面的元素比前面的元素小则用一个变量min来记住他的位置，接着第二次比较，前面“后一个元素”现变成了“前一个元素”，继续跟他的“后一个元素”进行比较如果后面的元素比他要小则用变量k记住它在数组中的位置(下标)，等到循环结束的时候，我们应该找到了最小的那个数的下标了，然后进行判断，如果这个元素的下标不是第一个元素的下标，就让第一个元素跟他交换一下值，这样就找到整个数组中最小的数了。然后找到数组中第二小的数，让他跟数组中第二个元素交换一下值，以此类推
 */
- (void)basicSelectedSort:(NSMutableArray *)array
{
    for(int i = 0 ; i < array.count - 1 ; i++) {
        int  min=i;//查找最小值
        for(int j = i + 1 ; j < array.count ; j++)
            if([array[min] intValue]>[array[j] intValue])
                min = j;//交换
        if(min!=i) {
            [array exchangeObjectAtIndex:min withObjectAtIndex:i];
        }
    }
}


//快速排序
//假设要排序的数组是A[0]……A[N-1]，首先任意选取一个数据（通常选用数组的第一个数）作为关键数据，然后将所有比它小的数都放到它前面，所有比它大的数都放到它后面，这个过程称为一趟快速排序。值得注意的是，快速排序不是一种稳定的排序算法，也就是说，多个相同的值的相对位置也许会在算法结束时产生变动。
//一趟快速排序的算法是：
//1）设置两个变量i、j，排序开始的时候：i=0，j=N-1；
//2）以第一个数组元素作为关键数据，赋值给key，即key=A[0]；
//3）从j开始向前搜索，即由后开始向前搜索(j–)，找到第一个小于key的值A[j]，将A[j]和A[i]互换；
//4）从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于key的A[i]，将A[i]和A[j]互换；
//5）重复第3、4步，直到i=j； (3,4步中，没找到符合条件的值，即3中A[j]不小于key,4中A[i]不大于key的时候改变j、i的值，使得j=j-1，i=i+1，直至找到为止。找到符合条件的值，进行交换的时候i， j指针位置不变。另外，i==j这一过程一定正好是i+或j-完成的时候，此时令循环结束）。

- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}


- (void) quickSortFromLeft:(NSInteger)leftIndex toRight:(NSInteger)rightIndex array:(NSMutableArray *)array {
    
    if (leftIndex >= rightIndex) {
        return;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger base = [array[leftIndex] integerValue];
    
    
    while (i != j) {
        while ([array[j] integerValue] >= base && i < j) {
            j --;
        }
        while ([array[i] integerValue] <= base && i < j) {
            i ++;
        }
        
        if (i < j) {
            NSInteger temp = [array[j] integerValue];
            array[j] = array[i];
            array[i] = [NSNumber numberWithInteger:temp];
            
        }
    }
    
    NSInteger temp = [array[j] integerValue];
    array[j] = [NSNumber numberWithInteger:base];
    array[leftIndex] = [NSNumber numberWithInteger:temp];
    
    
    [self quickSortFromLeft:leftIndex toRight:i-1 array:array];
    [self quickSortFromLeft:i+1 toRight:rightIndex array:array];
}


@end
