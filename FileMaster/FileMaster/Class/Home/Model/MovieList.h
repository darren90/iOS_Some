//
//  MovieList.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    FileMovieCanPlay,
    FileMovieCanNotPlay,
    FileImage,
    FileZIP,
    FileFolder,
    FileOther
} FileType;
@interface MovieList : NSObject

/**
 *  文件名字
 */
@property (nonatomic,copy)NSString * name;
/**
 *  文件类型
 */
@property (nonatomic,assign)FileType fileType;
/**
 *  视频截图
 */
@property (nonatomic,strong)UIImage *imgData;
/**
 *  路径 eg： /Users/tengfei/Library/Developer/CoreSimulator/Devices/9620CFF0-FF3B-432B-8BDD-9FE55A05853D/data/Containers/Data/Application/53477C41-CB47-4AA9-890D-11B243BEEBD7/Documents/123.mp4
 */
@property (nonatomic,copy)NSString * path;

/**
 *  相对于Documents的路径 eg：123.mp4
 */
@property (nonatomic,copy)NSString * relaPath;

//文件大小
@property (nonatomic,copy)NSString * fileSize;

+(instancetype)movieList:(NSString *)name fileType:(FileType)fileType path:(NSString *)path fileSize:(NSString *)fileSize;


+(instancetype)movieList:(NSString *)name fileType:(FileType)fileType path:(NSString *)path imgData:(UIImage *)imgData;

@end
