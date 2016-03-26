//
//  AboutViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let version = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        versionLabel.text = "Version:\(version)"
    }
    
    @IBAction func goWeibo(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://weibo.com/fengtengfei90")!)
    }
    
    @IBAction func goGitHub(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/darren90")!)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
