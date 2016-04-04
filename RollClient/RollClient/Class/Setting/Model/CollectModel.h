//
//  CollectModel.h
//  MovieBinge
//
//  Created by Fengtf on 16/1/21.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectModel : NSObject
//[_db executeUpdate:@"CREATE TABLE if not exists movieCollect (id integer primary key autoincrement,movieId TEXT,episode integer,episodeSid TEXT,quality TEXT,coverUrl TEXT,score,TEXT)"];


@property (nonatomic,copy)NSString * movieId;

@property (nonatomic,assign)int episode;

@property (nonatomic,copy)NSString * episodeSid;

@property (nonatomic,copy)NSString * quality;

@property (nonatomic,copy)NSString * coverUrl;

@property (nonatomic,copy)NSString * score;

@property (nonatomic,copy)NSString * title;

@property (nonatomic,copy)NSString * brief;



@end
