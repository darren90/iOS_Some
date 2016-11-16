//
//  Rank_Word.h
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rank_Word : NSObject
//rank_year , rank , last_rank , co_name,co_detailurl , income , profit , nation

@property (nonatomic,copy)NSString * rank_year;
@property (nonatomic,copy)NSString * rank;
@property (nonatomic,copy)NSString * last_rank;
@property (nonatomic,copy)NSString * co_name;
@property (nonatomic,copy)NSString * co_detailurl;
@property (nonatomic,copy)NSString * income;
@property (nonatomic,copy)NSString * profit;
@property (nonatomic,copy)NSString * nation;

@end
