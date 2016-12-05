//
//  MovieFolderViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieFolderViewController.h"
#import "MovieList.h"
#import "MovieFile.h"
#import "MovieListCell.h"
#import "TFMoviePlayerViewController.h"

@interface MovieFolderViewController ()
@property (nonatomic,strong)NSMutableArray * dataArray;
- (IBAction)backToRootVc:(UIBarButtonItem *)sender;

@end

@implementation MovieFolderViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"文件夹界面"];
    
    self.dataArray = (NSMutableArray *)self.file.subFiles;//[self getMovieList];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"文件夹界面"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 66;
    self.title = self.file.folderName;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListCell  *cell = [MovieListCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieFile *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (model.isFolder) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MovieFolderViewController *folderVc = [sb instantiateViewControllerWithIdentifier:@"folderVc"];
        folderVc.file = model;
        [self.navigationController pushViewController:folderVc animated:YES];
    }else{
        MovieList *list = model.file;
        if (list.fileType == FileMovieCanPlay) {
            TFMoviePlayerViewController *playerVc = [[TFMoviePlayerViewController alloc] init];
            playerVc.topTitle = list.name;
            playerVc.playLocalUrl = list.relaPath;
            [self.navigationController presentViewController:playerVc animated:YES completion:nil];
        }else if (list.fileType == FileImage){
            
        }
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieFile *file = self.dataArray[indexPath.row];
    MovieList *model = file.file;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //1：局部删除一行的刷新
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        if (file.isFolder) {
            [WdCleanCaches deleteDownloadFileWithFilePath:file.path];
        }else{
            [WdCleanCaches deleteDownloadFileWithFilePath:model.path];
        }
    }
    
}


- (IBAction)backToRootVc:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
