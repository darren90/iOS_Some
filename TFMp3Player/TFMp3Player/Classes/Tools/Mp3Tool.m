//
//  Mp3Tool.m
//  TFMp3Player
//
//  Created by Tengfei on 16/5/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Mp3Tool.h"
#import "MusicModel.h"

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
@end
