//
//  HomeSearchViewController.m
//  RollClient
//
//  Created by Tengfei on 16/5/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeSearchViewController.h"

@interface HomeSearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)DownClick:(UIBarButtonItem *)sender;
 
@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)DownClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
