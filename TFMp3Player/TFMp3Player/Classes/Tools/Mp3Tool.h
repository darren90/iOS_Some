//
//  Mp3Tool.h
//  TFMp3Player
//
//  Created by Tengfei on 16/5/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicModel;
@interface Mp3Tool : NSObject
/**
 *  正在播放的歌曲
 *
 */
+ (MusicModel *)playingMusic;
/**
 *  重新设置歌曲
 *
 */
+ (void)setPlayingMusic:(MusicModel *)playingMusic;

/**
 *
 *
 *  @return 所有歌曲
 */
+ (NSArray *)musics;

/**
 *
 *  下一首歌曲
 */
+ (MusicModel *)nextMusic;

/**
 *  上一首歌曲
 *
 */
+ (MusicModel *)previousMusic;
@end
