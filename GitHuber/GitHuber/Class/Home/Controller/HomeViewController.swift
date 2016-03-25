//
//  HomeViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        let sb = UIStoryboard(name: "Main", bundle: nil);
//        let userVc = sb.instantiateViewControllerWithIdentifier("UserDetail") as! UserDetailViewController;
//        self.navigationController?.pushViewController(userVc, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        APINetTools.get("users/daimajia", params: nil, success: { (json) -> Void in
            print(json)
            }) { (error) -> Void in
                print(error)
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let sb = UIStoryboard(name: "Main", bundle: nil);
//        let userVc = sb.instantiateViewControllerWithIdentifier("UserDetail") as! UserDetailViewController;
//        self.navigationController?.pushViewController(userVc, animated: true)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
