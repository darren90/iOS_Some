//
//  ExploreViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

//https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc
class ExploreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func chooseLanguage(sender: UIBarButtonItem) {
        
    }
    
    
    
    

}
