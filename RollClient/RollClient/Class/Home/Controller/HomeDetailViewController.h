//
//  HomeDetailViewController.h
//  RollClient
//
//  Created by Fengtf on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RollModel;
@interface HomeDetailViewController : UIViewController


 
@property (nonatomic,copy)NSString * itemId;

@property (nonatomic,copy)NSString * itemType;

//收藏 要用到的model
@property (nonatomic,strong)RollModel *collectModel;

@end
