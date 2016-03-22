//
//  HomeViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APINetTools.get("users/darren90", params: nil, success: { (json) -> Void in
            print(json)
            }) { (error) -> Void in
                print(error)
        }
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
