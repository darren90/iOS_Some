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
        
        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.barStyle = .Default
        searchBar.delegate = self
        searchBar.placeholder = "Search Users,Repos"
//        searchBar.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(SearchSwipeViewController.close))
        
        let pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        let swip = RKSwipeBetweenViewControllers(rootViewController: pageController)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let v1 = sb.instantiateViewControllerWithIdentifier("SearchUserViewController") as! SearchUserViewController
        let v2 = sb.instantiateViewControllerWithIdentifier("SearchReposViewController") as! SearchReposViewController
        
        
        swip.buttonText =  ["Users","Repositories"]
        swip.viewControllerArray = [v1,v2]
        pageController.view.backgroundColor = UIColor.clearColor()
        swip.view.backgroundColor = UIColor.whiteColor()
        v1.view.backgroundColor = UIColor .brownColor()
        v2.view.backgroundColor = UIColor .grayColor()
        
        self.addChildViewController(swip)
        self.view .addSubview(swip.view)
        swip.view.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height)
//        swip.navigationView!.backgroundColor = UIColor.redColor()
    }
    
    
    func close() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
}




extension SearchSwipeViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
    }
    
}






