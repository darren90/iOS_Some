//
//  NSString+TF.m
//  RollClient
//
//  Created by Tengfei on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "NSString+TF.h"

@implementation NSString (TF)



#pragma mark - 取出html的标签
+ (NSString *)replaceHtmlTag:(NSString *)commentContent
{
    commentContent = [commentContent stringByReplacingOccurrencesOfRegex:@"<[\\s|\\S]*?>" withString:@""];
    commentContent = [commentContent stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    commentContent = [commentContent stringByReplacingOccurrencesOfString:@"&nbsp" withString:@" "];
    commentContent = [commentContent stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    commentContent = [self replaceEnter:commentContent];
    commentContent = [commentContent stringByReplacingOccurrencesOfString:@" " withString:@""];
    return commentContent;
}

+(NSString *)replaceEnter:(NSString *)str
{
    if (str == nil) {
        return @"";
    }
    if ([str rangeOfString:@"\n\n"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
        str = [self replaceEnter:str];
    }
    if ([str hasPrefix:@"\n"]||[str hasSuffix:@"\n"]) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return str;
}

- (NSString*)replaceEnterString:(NSString *)str
{
    return  [NSString replaceEnter:self];;
}


@end
