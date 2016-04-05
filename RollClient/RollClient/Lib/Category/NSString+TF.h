//
//  NSString+TF.h
//  RollClient
//
//  Created by Tengfei on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TF)


#pragma mark - 取出html的标签
/**
 *  替换html标签
 *
 *  @param commentContent 要替换的内容
 *
 *  @return 替换后没有html标签的内容
 */
+(NSString *)replaceHtmlTag:(NSString *)commentContent;

@end
