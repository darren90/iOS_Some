//
//  GDTAdvertView.h
//  FileMaster
//
//  Created by Tengfei on 2017/4/29.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTAdvertView : UIView

-(instancetype)initWithMovieList:(BOOL)isMovieList;

@property (nonatomic,assign)BOOL isMovieList;

@end
