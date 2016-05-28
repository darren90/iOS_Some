//
//  ViewController.m
//  TFMp3Player
//
//  Created by Tengfei on 16/5/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import "Mp3Tool.h"
#import "MusicListCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"音乐播放器";
    NSArray *arr = [Mp3Tool scanMusics];
    [self.dataArray addObjectsFromArray:arr];
}

#pragma mark ----TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicListCell *cell = [MusicListCell musicCellWithTableView:tableView];
//    cell.music = [ZYMusicTool musics][indexPath.row];
    return cell;
}

#pragma mark ----TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [ZYMusicTool setPlayingMusic:[ZYMusicTool musics][indexPath.row]];
//    ZYMusic *preMusic = [ZYMusicTool musics][self.currentIndex];
//    preMusic.playing = NO;
//    ZYMusic *music = [ZYMusicTool musics][indexPath.row];
//    music.playing = YES;
//    NSArray *indexPaths = @[
//                            [NSIndexPath indexPathForItem:self.currentIndex inSection:0],
//                            indexPath
//                            ];
//    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//    
//    self.currentIndex = (int)indexPath.row;
//    
//    [self.playingVc show];
}


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
