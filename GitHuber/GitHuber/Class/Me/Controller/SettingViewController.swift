//
//  SettingViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = KColor(250, g: 250, b: 250)
        return view
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = KColor(250, g: 250, b: 250)
        return view
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {//go to App Store
             let url = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(KAppid)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }else if (indexPath.section == 1){// about
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("aboutVc") as! AboutViewController
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    

}
 