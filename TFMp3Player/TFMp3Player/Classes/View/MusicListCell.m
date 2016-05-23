//
//  MusicListCell.m
//  TFMp3Player
//
//  Created by Tengfei on 16/5/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MusicListCell.h"
#import "MusicModel.h"
//#import "ZYImageTool.h"
//#import "Colours.h"
#import "UIImage+Tool.h"
static NSString *_identifier = @"ZYMusicCell";
@implementation MusicListCell


+ (instancetype)musicCellWithTableView:(UITableView *)tableView
{
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (cell == nil) {
        cell = [[MusicListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:_identifier]) {
        
    }
    return self;
}

- (void)setMusic:(MusicModel *)music
{
    _music = music;
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    
    if (music.isPlaying) {
        self.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2.0 borderColor:[UIColor eggshellColor]];
    }
    else{
        self.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2.0 borderColor:[UIColor pinkColor]] ;
    }
}
@end
