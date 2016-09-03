//
//  ScanResultViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ScanResultViewController.h"
#import "UIView+Toast.h"
//#import "UIPasteboard.h"

@interface ScanResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *scanImg;
@property (weak, nonatomic) IBOutlet UILabel *labelScanText;
@property (weak, nonatomic) IBOutlet UILabel *labelScanCodeType;
@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noDataView.hidden = YES;
    
    self.title = @"扫描结果";
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    dispatch_after(0.5, dispatch_get_main_queue(), ^{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:_strScan];
        [self.view makeToast:@"内容已复制到剪切板" duration:1.0 position:CSToastPositionBottom];
    });
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    if (!_imgScan) {
        _scanImg.backgroundColor = [UIColor grayColor];
    }

    _scanImg.image = _imgScan;
    _labelScanText.text = _strScan;
//    _labelScanCodeType.text = [NSString stringWithFormat:@"Type:%@",_strCodeType];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}





@end






