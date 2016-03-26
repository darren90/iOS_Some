//
//  BaseNavigationController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    //系统第一次使用这个类的时候会调用
//    +(void)initialize
//    {
//    //导航栏的主题
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBackgroundImage:[UIImage imageNamed:@"NarBar"] forBarMetrics:UIBarMetricsDefault];
//    
//    //去除navbar下面的线条
//    //    [navBar setShadowImage:[UIImage new]];
//    
//    //返回箭头的按钮的颜色
//    navBar.tintColor = [UIColor whiteColor];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [navBar setTitleTextAttributes:dict];
//    
//    //UIBarButtonItem主题设置
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    NSMutableDictionary *Ddict = [NSMutableDictionary dictionary];
//    Ddict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    Ddict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:Ddict forState:UIControlStateNormal];
//    
//    NSMutableDictionary *Hdict = [NSMutableDictionary dictionary];
//    Hdict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [item setTitleTextAttributes:Hdict forState:UIControlStateHighlighted];
//    
//    NSMutableDictionary *Disdict = [NSMutableDictionary dictionary];
//    Disdict[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:Disdict forState:UIControlStateDisabled];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
 
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//    forBarMetrics:UIBarMetricsDefault];
    
    override class func initialize(){
        //导航栏主题
        let navBar = UINavigationBar.appearance()
        navBar.backgroundColor = UIColor.whiteColor()
        navBar.setBackgroundImage(UIImage(named: "NarBar"), forBarMetrics: .Default)
        
        navBar.tintColor = UIColor.whiteColor()
 
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        //设置按钮的三个状态
        let item = UIBarButtonItem.appearance()
        item .setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor() , NSFontAttributeName : UIFont.systemFontOfSize(16)], forState: .Normal)
        item .setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightGrayColor() , NSFontAttributeName : UIFont.systemFontOfSize(16)], forState: .Highlighted)
        item .setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.grayColor() , NSFontAttributeName : UIFont.systemFontOfSize(16)], forState: .Disabled)

        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
 
    

    //- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
    //{
    //    // fix 'nested pop animation can result in corrupted navigation bar'
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.enabled = NO;
    //    }
    //    //    NSLog(@"subVCs:%lu",(unsigned long)self.viewControllers.count);
    //    if (self.viewControllers.count > 0) {
    //        viewController.hidesBottomBarWhenPushed = YES;
    //        self.tabBarController.tabBar.backgroundColor = [UIColor clearColor];
    //    }
    //
    //    [super pushViewController:viewController animated:animated];
    //}
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            self.tabBarController?.tabBar.backgroundColor = UIColor.clearColor()
        }
        super.pushViewController(viewController, animated: animated)
    }


}
