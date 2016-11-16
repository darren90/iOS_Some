//
//  Rank_Word_HeaderView.m
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Rank_Word_HeaderView.h"

@implementation Rank_Word_HeaderView

+(instancetype)headerView
{
    return [[NSBundle mainBundle]loadNibNamed:@"Rank_Word_HeaderView" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib
{
    
}

@end
