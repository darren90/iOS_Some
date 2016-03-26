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
