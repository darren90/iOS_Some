//
//  RollModel.m
//  RollClient
//
//  Created by Fengtf on 16/3/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RollModel.h"

@implementation RollModel
// NSCoding实现
MJCodingImplementation

+(NSDictionary *)objectClassInArray{
    return @{
             @"itemImageList" : @"ItemImags"
             };
}


-(void)setItemTitle:(NSString *)itemTitle
{
//    _itemTitle = itemTitle;
    
    _itemTitle = [NSString replaceHtmlTag:itemTitle];
//    NSLog(@"after:%@",_itemTitle);
}

@end
