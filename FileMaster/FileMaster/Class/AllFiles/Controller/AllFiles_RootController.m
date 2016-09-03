//
//  AllFiles_RootController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "AllFiles_RootController.h"
#import "MovieListCell.h"
#import "MovieList.h"
#import "MoviePlayerViewController.h"
#import "MovieFolderViewController.h"
#import "UIImage+Category.h"
#import "MovieFile.h"
#import "GetFilesTools.h"
#import "TFMoviePlayerViewController.h"
#import "AdvertView.h"

//#import "LBXScanView.h"
//#import "LBXScanResult.h"
//#import "LBXScanWrapper.h"


@interface AllFiles_RootController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)editList:(UIBarButtonItem *)sender;

@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation AllFiles_RootController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
//    NSArray *aa = [FCFileManager listFilesInDirectoryAtPath:docsDir deep:YES];
//    NSArray *aa2 = [FCFileManager listFilesInDirectoryAtPath:docsDir];

    NSMutableArray *pathArray =  [GetFilesTools scanFilesAtPath:docsDir];//[self scanFilesAtPath:docsDir];
    
    self.dataArray = pathArray;//[self getMovieList];
    if (self.dataArray.count == 0) {
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editList:)];
    }
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"saoyisao"] style:UIBarButtonItemStyleDone target:self action:@selector(saoyisao)];
    
    [self.tableView reloadData];
}

////二维码的扫一扫功能
//-(void)saoyisao
//{
//    
//    if (![self cameraPemission])
//    {
//        [self showError:@"没有摄像机权限"];
//        return;
//    }
//    
//}
//- (BOOL)cameraPemission
//{
//    
//    BOOL isHavePemission = NO;
//    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
//    {
//        AVAuthorizationStatus permission =
//        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        
//        switch (permission) {
//            case AVAuthorizationStatusAuthorized:
//                isHavePemission = YES;
//                break;
//            case AVAuthorizationStatusDenied:
//            case AVAuthorizationStatusRestricted:
//                break;
//            case AVAuthorizationStatusNotDetermined:
//                isHavePemission = YES;
//                break;
//        }
//    }
//    
//    return isHavePemission;
//}
//- (void)showError:(NSString*)str
//{
////    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
//    NSLog(@"no persion");
//}

//#pragma mark -模仿qq界面
//- (void)qqStyle
//{
//    //设置扫码区域参数设置
//    
//    //创建参数对象
//    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
//    
//    //矩形区域中心上移，默认中心点为屏幕中心点
//    style.centerUpOffset = 44;
//    
//    //扫码框周围4个角的类型,设置为外挂式
//    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
//    
//    //扫码框周围4个角绘制的线条宽度
//    style.photoframeLineW = 6;
//    
//    //扫码框周围4个角的宽度
//    style.photoframeAngleW = 24;
//    
//    //扫码框周围4个角的高度
//    style.photoframeAngleH = 24;
//    
//    //扫码框内 动画类型 --线条上下移动
//    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
//    
//    //线条上下移动图片
//    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
//    
//    //SubLBXScanViewController继承自LBXScanViewController
//    //添加一些扫码或相册结果处理
//    SubLBXScanViewController *vc = [SubLBXScanViewController new];
//    vc.style = style;
//    
//    vc.isQQSimulator = YES;
//    vc.isVideoZoom = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initTableview];

    // 设置tableView在编辑模式下可以多选，并且只需设置一次
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
   
    //滑动隐藏navBar
//    self.navigationController.hidesBarsOnSwipe = YES;
    
    self.tableView.rowHeight = 66;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49+64+50, 0);
//    self.tableView.backgroundColor = [UIColor blueColor];
    
    [self initAdView];
}

-(void)initAdView{
    AdvertView *adView = [[AdvertView alloc]init];
    [self.view addSubview:adView];
    adView.frame = CGRectMake(0, KHeight-49-64-50, KWidth, 50);
    adView.bannerView.rootViewController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.noDataView.hidden = (self.dataArray.count != 0);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListCell  *cell = [MovieListCell cellWithTableView:tableView];//[tableView dequeueReusableCellWithIdentifier:@"movielistCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing)    return ;
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
            @try{
                TFMoviePlayerViewController *playerVc = [[TFMoviePlayerViewController alloc] init];
                playerVc.topTitle = list.name;
                playerVc.playLocalUrl = list.name;
                [self.navigationController presentViewController:playerVc animated:YES completion:nil];
            }
            @catch(NSException *exception) {
                KLog(@"exception:%@", exception);
            }
            @finally {
                
            }
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


- (NSMutableArray *)scanFilesAtPath:(NSString *)direString {
    NSMutableArray *pathArray = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:direString error:nil];
    for (NSString *fileName in tempArray) {
        MovieFile *movieFile = [[MovieFile alloc]init];
        
        UIImage *imgData ;
        FileType fileType;
        MovieList *model;
        
        BOOL flag = YES;
        NSString *fullPath = [direString stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                // ignore .DS_Store
                if (![[fileName substringToIndex:1] isEqualToString:@"."]) {
                    
                    if ([fileName hasSuffix:@".mp4"]) {
                        imgData = [UIImage thumbnailImageForVideo:[NSURL fileURLWithPath:fullPath] atTime:10.0];
                        fileType = FileMovieCanPlay;
                    }else if([fileName hasSuffix:@".png"]){
                        imgData = [UIImage imageWithContentsOfFile:fullPath];
                        fileType = FileImage;
                    }else {
                        imgData = [UIImage imageNamed:@"Finder_files"];
                        fileType = FileOther;
                    }
                    model = [MovieList movieList:fileName fileType:fileType path:fullPath imgData:imgData];
                    
                    movieFile.isFolder = NO;
                    movieFile.file = model;
                    
                    [pathArray addObject:movieFile];
                }
            }
            else {
                movieFile.isFolder = YES;
                movieFile.subFiles = [self scanFilesAtPath:fullPath];
                movieFile.folderName = fileName;
                //                [pathArray addObject:[self scanFilesAtPath:fullPath]];
                [pathArray addObject:movieFile];
            }
        }
    }
    return pathArray;
}

/**
 iOS 视频 帧
 http://blog.txx.im/blog/2013/09/04/ios-avassertimagegenerator/
 http://blog.csdn.net/ALDRIDGE1/article/details/24327929
 
 */

/**
 *  编辑视频--：删除+加密
 *
 *  @param sender
 */
- (IBAction)editList:(UIBarButtonItem *)sender {
    sender.title = self.tableView.isEditing ? @"编辑" : @"完成" ;

    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    
    
}
@end
