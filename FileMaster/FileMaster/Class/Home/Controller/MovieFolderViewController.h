//
//  MovieFolderViewController.h
//  FileMaster
//
//  Created by Tengfei on 16/3/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base_TableViewController.h"

@class MovieFile;
@interface MovieFolderViewController : Base_TableViewController

@property (nonatomic,strong)MovieFile *file;


@end
