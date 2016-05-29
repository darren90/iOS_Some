//
//  Mp3Tool.m
//  TFMp3Player
//
//  Created by Tengfei on 16/5/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Mp3Tool.h"
#import "MusicModel.h"
#import "MJExtension.h"

static NSArray *_musics;
static MusicModel *_playingMusic;

@implementation Mp3Tool

+ (NSArray *)musics
{
    if (_musics == nil) {
//        _musics = [MusicModel objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

+ (MusicModel *)playingMusic
{
    return _playingMusic;
}

+ (void)setPlayingMusic:(MusicModel *)playingMusic
{
    if (playingMusic == nil || ![_musics containsObject:playingMusic] || playingMusic == _playingMusic) {
        return;
    }
    _playingMusic = playingMusic;
}


+ (MusicModel *)nextMusic
{
    int nextIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[[self musics] indexOfObject:_playingMusic];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    return [self musics][nextIndex];
}

+ (MusicModel *)previousMusic
{
    int previousIndex = 0;
    if (_playingMusic) {
        int playingIndex = (int)[[self musics] indexOfObject:_playingMusic];
        previousIndex = playingIndex - 1;
        if (previousIndex < 0) {
            previousIndex = (int)[self musics].count - 1;
        }
    }
    return [self musics][previousIndex];
}

+(NSMutableArray *)scanMusics
{
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    return [self scanMusics2:docsDir];
}

+ (NSMutableArray *)scanMusics2:(NSString *)path {
    NSMutableArray *pathArray = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in tempArray) {
        
        NSLog(@"--:%@",fileName);
//        MovieFile *movieFile = [[MovieFile alloc]init];
//        UIImage *imgData ;
//        FileType fileType;
//        MovieList *model;
//        
//        BOOL flag = YES;
//        NSString *fullPath = [direString stringByAppendingPathComponent:fileName];
//        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
//            if (!flag) {
//                // ignore .DS_Store
//                if (![[fileName substringToIndex:1] isEqualToString:@"."]) {
//                    
//                    if ([fileName hasSuffix:@".mp4"]) {
//                        imgData = [UIImage thumbnailImageForVideo:[NSURL fileURLWithPath:fullPath] atTime:200.0];
//                        fileType = FileMovieCanPlay;
//                        [pathArray addObject:movieFile];
//                        
//                    }else if([fileName hasSuffix:@".png"] || [fileName hasSuffix:@".jpg"]){
//                        imgData = [UIImage imageWithContentsOfFile:fullPath];
//                        fileType = FileImage;
//                    }else if([fileName hasSuffix:@".zip"] || [fileName hasSuffix:@".rar"]){//压缩文件
//                        imgData = [UIImage imageNamed:@"file_zip"];
//                        fileType = FileZIP;
//                    }else {
//                        imgData = [UIImage imageNamed:@"file_new"];
//                        fileType = FileOther;
//                    }
//                    model = [MovieList movieList:fileName fileType:fileType path:fullPath imgData:imgData];
//                    
//                    movieFile.isFolder = NO;
//                    movieFile.file = model;
//                }
//            }
//            else {
//                //                movieFile.isFolder = YES;
//                //                movieFile.subFiles = [self scanFilesAtPath:fullPath];
//                //                movieFile.folderName = fileName;
//                //                [pathArray addObject:movieFile];
//                [self scanFilesAtPath:fullPath];
//            }
//        }
    }
    return pathArray;
}

@end
