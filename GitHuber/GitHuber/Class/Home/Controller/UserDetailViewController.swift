//
//  UserDetailViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserDetailViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70
        // Do any additional setup after loading the view.
        tableView.addSubview(headerView)
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: 320, height: 200)
//        headerView.snp_makeConstraints(closure: { (make) -> Void in
//          make.height.equalTo(200)
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

    private lazy var headerView:UserDetailHeader = {
        let header = NSBundle.mainBundle().loadNibNamed("UserDetailHeader", owner: nil, options: nil).first as! UserDetailHeader
//        header.backgroundColor = U
        
        return header
    }()

}


//lazy var box = UIView()
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    self.view.addSubview(box)
//    box.snp_makeConstraints { (make) -> Void in
//        make.width.height.equalTo(50)
//        make.center.equalTo(self.view)
//    }
//}

extension UserDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
        return cell;
    }
    
    
}