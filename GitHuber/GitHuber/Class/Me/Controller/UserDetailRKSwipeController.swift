//
//  UserDetailRKSwipeController.swift
//  GitHuber
//
//  Created by Fengtf on 16/3/31.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserDetailRKSwipeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        let swip = RKSwipeBetweenViewControllers(rootViewController: pageController)
        
        let v1 = UIViewController()
        let v2 = UIViewController()
        let v3 = UIViewController()
        
        swip.buttonText = ["美剧","韩剧","泰剧"]
        swip.viewControllerArray = [v1,v2,v3]
        v1.view.backgroundColor = UIColor .brownColor()
        v2.view.backgroundColor = UIColor .grayColor()
        v3.view.backgroundColor = UIColor .cyanColor()
     
        self.addChildViewController(swip)
        self.view .addSubview(swip.view)
        swip.view.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
