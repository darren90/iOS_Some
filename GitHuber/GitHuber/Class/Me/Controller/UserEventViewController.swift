//
//  UserEventViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserEventViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    //    https://api.github.com/users/darren90/received_events?&page=1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trends"
        tableView.registerNib(UINib(nibName: "UserRankCell",bundle:nil), forCellReuseIdentifier: "UserRankCell")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}



extension UserEventViewController:UITableViewDelegate,UITableViewDataSource{
    
    //MARK - tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
        return cell;
    }
    
    //MARK - DLTabedSlideViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

