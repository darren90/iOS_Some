//
//  AppDelegate.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTSplashAd.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GDTSplashAdDelegate>

@property (strong, nonatomic) UIWindow *window;


/***  是否允许横屏的标记 Yes:允许，NO:不允许 */
@property (nonatomic,assign)BOOL allowRotation;


//http://www.cnblogs.com/xjy-123/p/5163128.html
//如何用代码控制以不同屏幕方向打开新页面
//http://www.cocoachina.com/ios/20150810/12895.html
@end

