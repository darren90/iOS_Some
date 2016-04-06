//
//  RollModel.h
//  RollClient
//
//  Created by Fengtf on 16/3/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RollModel : NSObject

//"createTime":1459167395000,
//"createTimeString":"2016-03-28 20:16:35",
//"itemId":3818,
//"itemImageList":Array[3],
//"itemTag":"/group/6267121792360808706/",
//"itemTitle":"?????| ???????????A4 <span style="color:#ca4f4f"> ? </span> ??"


@property (nonatomic,copy)NSString * createTime;

@property (nonatomic,copy)NSString * createTimeString;

@property (nonatomic,copy)NSString * itemId;

@property (nonatomic,strong)NSArray * itemImageList;

@property (nonatomic,copy)NSString * itemTag;

@property (nonatomic,copy)NSString * itemTitle;

@property (nonatomic,copy)NSString * itemType;


@end
