//
//  HistoryCellModel.h
//  PUClient
//
//  Created by 郭旭 on 15/12/11.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryCellModel : NSObject
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * episode;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * movieID;
@property (nonatomic, assign)double lastDuration;
@property (nonatomic, assign)int urlType;
@property (nonatomic, copy)NSString * quality;
@property (nonatomic, copy)NSString * webUrl;
@property (nonatomic, copy)NSString * enTitle;
@property (nonatomic, copy)NSString * episodeID;
@property (nonatomic, copy)NSString * ID;
@property (nonatomic, copy)NSString * coverUrl;
@end
