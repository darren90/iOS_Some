//
//  HomeSearchViewController.h
//  RollClient
//
//  Created by Tengfei on 16/5/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSearchViewController : UIViewController

//其 父控制器
@property (nonatomic,weak)UIViewController * fatherVC;

/**
 *  搜索的关键字
 */
@property (nonatomic,copy)NSString * searchText;


@end
