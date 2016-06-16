//
//  TFVideoPlayerViewController.h
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRPlayer.h"

@interface TFVideoPlayerViewController : UIViewController
@property (nonatomic, strong) RRVideoPlayer* player;



@property (nonatomic,copy)NSURL * playUrl;

/**
 *  小屏播放器要用到
 *
 *  @param url 播放地址
 */
- (void)playStream:(NSURL*)url;
-(void)playChangeStreamUrl:(NSURL *)url;


#pragma mark - 卸载播放器
-(void)unInstallPlayer;
@end
