//
//  ViewController.m
//  TFMp3Player
//
//  Created by Tengfei on 16/5/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import "Mp3Tool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"音乐播放器";
    NSArray *arr = [Mp3Tool scanMusics];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
