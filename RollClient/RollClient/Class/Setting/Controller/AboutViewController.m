//
//  AboutViewController.m
//  RollClient
//
//  Created by Fengtf on 16/4/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Page_关于"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Page_关于"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本%@",appVersion];
}

- (IBAction)aboutAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://112.74.95.46"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
