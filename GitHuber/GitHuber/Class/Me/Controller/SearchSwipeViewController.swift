//
//  SearchViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SearchSwipeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        let swip = RKSwipeBetweenViewControllers(rootViewController: pageController)
        
        let v1 = UIViewController()
        let v2 = UIViewController()
        
        
        swip.buttonText =  ["Users","Repositories"]
        swip.viewControllerArray = [v1,v2]
        v1.view.backgroundColor = UIColor .brownColor()
        v2.view.backgroundColor = UIColor .grayColor()
        
        self.addChildViewController(swip)
        self.view .addSubview(swip.view)
        swip.view.frame = view.bounds
    }

    
}
