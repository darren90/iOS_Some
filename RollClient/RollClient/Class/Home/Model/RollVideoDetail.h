//
//  RollVideoDetail.h
//  RollClient
//
//  Created by Fengtf on 16/4/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RollVideoDetail : NSObject
//"createTime":1459868697000,
//"createTimeString":"2016-04-05",
//"itemVideoId":347,
//"videoId":4531,
//"videoPoster":"http://p1.pstatp.com/large/3e30009054f1fdc8032",
//"videoSrc":"4f9f6d3dead94b5fa77049cb32f51bf1",
//"videoType":"video/mp4"


@property (nonatomic,copy)NSString * createTime;

@property (nonatomic,copy)NSString * createTimeString;

@property (nonatomic,copy)NSString * itemVideoId;

@property (nonatomic,copy)NSString * videoPoster;

@property (nonatomic,copy)NSString * videoSrc;

@property (nonatomic,copy)NSString * videoType;


@end
