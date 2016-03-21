//
//  ViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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


}

