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
        NSLog(@"---");
    }
    return self;
}


- (void)run{
    [self bubblingAction];
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

- (void)bubblingAction {
    NSArray *array = @[@1,@23,@43,@5,@67,@89,@6,@3,@43,@11,@23,@22];
    NSMutableArray *bubbleArray = [NSMutableArray arrayWithArray:array];
//    [self bubbleSort:bubbleArray];
//    [self basicSelectedSort:bubbleArray];
    
//    [self quickSort:bubbleArray low:0 high:bubbleArray.count];
//    [self quickSortArray:bubbleArray withLeftIndex:0 andRightIndex:bubbleArray.count-1];

    [self inserSort:bubbleArray];


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
    for (int i = 0; i< array.count; i++) {
        for (int y = 0; y < array.count - 1 - i; y++) {
            if ([array[y] intValue] > [array[y+1] intValue]) {
                [array exchangeObjectAtIndex:y+1 withObjectAtIndex:y];
            }
        }
    }
}

/*
 选择排序:
    对比数组中前一个元素跟后一个元素的大小，如果后面的元素比前面的元素小则用一个变量min来记住他的位置，接着第二次比较，前面“后一个元素”现变成了“前一个元素”，继续跟他的“后一个元素”进行比较如果后面的元素比他要小则用变量k记住它在数组中的位置(下标)，等到循环结束的时候，我们应该找到了最小的那个数的下标了，然后进行判断，如果这个元素的下标不是第一个元素的下标，就让第一个元素跟他交换一下值，这样就找到整个数组中最小的数了。然后找到数组中第二小的数，让他跟数组中第二个元素交换一下值，以此类推
 */
- (void)selectedSort:(NSMutableArray *)array
{
    int  min = 0;
    for(int i = 0 ; i < array.count - 1 ; i++) {
        min = i;//查找最小值
        for(int j = i + 1 ; j < array.count ; j++)
            if([array[min] intValue] > [array[j] intValue]) {
            [array exchangeObjectAtIndex:min withObjectAtIndex:j];
        }
    }
    if(array == nil || array.count == 0){
        return;
    }
}

/*
 快速排序
    假设要排序的数组是A[0]……A[N-1]，首先任意选取一个数据（通常选用数组的第一个数）作为关键数据，然后将所有比它小的数都放到它前面，所有比它大的数都放到它后面，这个过程称为一趟快速排序。值得注意的是，快速排序不是一种稳定的排序算法，也就是说，多个相同的值的相对位置也许会在算法结束时产生变动。
    一趟快速排序的算法是：
    1）设置两个变量i、j，排序开始的时候：i=0，j=N-1；
    2）以第一个数组元素作为关键数据，赋值给key，即key=A[0]；
    3）从j开始向前搜索，即由后开始向前搜索(j–)，找到第一个小于key的值A[j]，将A[j]和A[i]互换；
    4）从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于key的A[i]，将A[i]和A[j]互换；
    5）重复第3、4步，直到i=j； (3,4步中，没找到符合条件的值，即3中A[j]不小于key,4中A[i]不大于key的时候改变j、i的值，使得j=j-1，i=i+1，直至找到为止。找到符合条件的值，进行交换的时候i， j指针位置不变。另外，i==j这一过程一定正好是i+或j-完成的时候，此时令循环结束）。
*/
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

/*
 2、快速排序
 原理：从数列中挑出一个元素，成为“基准”，重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以放在任一边），在这个分区退出之后，该基准就处于数列的中间位置，递归的把小于基准值元素的子数列和大于基准值元素的子数列排序。
 OC代码实现：
 */
- (void)quickSort:(NSMutableArray *)array low:(int)low high:(int)high {
    if(array == nil || array.count == 0){
        return;
    }
    if (low >= high) {
        return;
    }

    //取中值
    int middle = low + (high - low)/2;
    NSNumber *prmt = array[middle];
    int i = low;
    int j = high;

    //开始排序，使得left<prmt 同时right>prmt
    while (i <= j) {
        //        while ([array[i] compare:prmt] == NSOrderedAscending) {  该行与下一行作用相同
        while ([array[i] intValue] < [prmt intValue]) {
            i++;
        }
        //        while ([array[j] compare:prmt] == NSOrderedDescending) { 该行与下一行作用相同
        while ([array[j] intValue] > [prmt intValue]) {
            j--;
        }

        if(i <= j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
    }

    if (low < j) {
        [self quickSort:array low:low high:j];
    }
    if (high > i) {
        [self quickSort:array low:i high:high];
    }
}


/*
 插入排序
    原理：从第一个元素开始，该元素可以认为已经被排序，取出下一个元素，在已经排序的元素序列中从后向前扫描，如果该元素（已排序）大于新元素，将该元素移到下一位置，重复以上步骤，直到找到已经排序的元素小于或者等于新元素的位置，将新元素插入到该位置中
 OC代码实现：
 */

- (void)inserSort:(NSMutableArray *)array {
    if(array == nil || array.count == 0){
        return;
    }

    for (int i = 0; i < array.count; i++) {
        NSNumber *temp = array[i];
        int j = i-1;

        while (j >= 0 && [array[j] intValue] > [temp intValue]) {
            [array replaceObjectAtIndex:j+1 withObject:array[j]];
            j--;
        }

        [array replaceObjectAtIndex:j+1 withObject:temp];
    }
}













@end
