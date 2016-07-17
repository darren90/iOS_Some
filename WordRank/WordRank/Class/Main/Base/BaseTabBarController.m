//
//  BaseTabBarController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//



#import "BaseTabBarController.h"
#import "RDVTabBarItem.h"
#import "BaseNavigationController.h"

#import "Home_RootController.h"
#import "Rank_RootController.h"
#import "Setting_RootController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  initViewControllers];
    //    NSArray *array =  self.viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewControllers
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    Home_RootController *home = [sb instantiateViewControllerWithIdentifier:@"home"];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc]initWithRootViewController:home];
    
    Rank_RootController *rank = [sb instantiateViewControllerWithIdentifier:@"rank"];
    BaseNavigationController *rankNav = [[BaseNavigationController alloc]initWithRootViewController:rank];
    
    Setting_RootController *settingVc = [sb instantiateViewControllerWithIdentifier:@"setting"];
    BaseNavigationController *settingNav = [[BaseNavigationController alloc]initWithRootViewController:settingVc];

//    [self setViewControllers:@[movielistNav,privateListNav, settingNav]];
    [self setViewControllers:@[homeNav,rankNav, settingNav]];
    
    [self initTabBarForController];
    self.delegate = self;
}

-(void)initTabBarForController
{
    NSArray *tabBarItemImages = @[@"gather",@"movie",@"setting"];
    NSArray *tabBarItemTitles = @[@"Home",@"Rank",@"Setting"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in self.tabBar.items) {
        item.titlePositionAdjustment = UIOffsetMake(0, 2);
//        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        [[UIImage imageNamed:@"refresh"] imageWithTintColor:[UIColor lightGrayColor]];

        NSString *selectStr = [NSString stringWithFormat:@"%@",
                               tabBarItemImages[index]];
        UIImage *selectedimage = [[UIImage imageNamed:selectStr] imageWithTintColor:KColor(106, 149, 218)];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        tabBarItemImages[index]]];
        
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        item.unselectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : KColor(153, 153, 153)};
        item.selectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : KColor(106, 149, 218)};
        
        index++;
    }
}

#pragma mark RDVTabBarControllerDelegate

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
    return YES;
}


/**
 *  Description
 *
 *  @return return value description
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


@end


