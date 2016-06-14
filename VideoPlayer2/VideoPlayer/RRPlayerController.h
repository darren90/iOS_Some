//
//  RRPlayerController.h
//  VideoPlayer
//
//  Created by Fengtf on 16/6/13.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRPlayer.h"

@interface RRPlayerController : UIViewController
@property (nonatomic, strong) RRVideoPlayer* player;



#pragma mark - 卸载播放器
-(void)unInstallPlayer;
@end
