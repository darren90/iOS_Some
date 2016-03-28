//
//  UserDetailViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

//box.snp_makeConstraints { (make) -> Void in
//    make.width.height.equalTo(50)
//    make.center.equalTo(self.view)
//}

import UIKit

class UserDetailViewController: BaseViewController {
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView3: UITableView!

    
    
    //外界传递的参数
    var loginName:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView1.rowHeight = 70
        
        var headerViewH:CGFloat  = 150.0
        let name = NSUserDefaults.standardUserDefaults().objectForKey("GitHubName") as? String
        if name != nil {
            headerViewH = 120
        }
        let headerRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: headerViewH)
        headerView.frame = headerRect
        headerView1.frame = headerRect
        headerView2.frame = headerRect
        headerView3.frame = headerRect
        
        //1
        tableView1.tableHeaderView = headerView1
        tableView1.sendSubviewToBack(headerView1)
        
        //2
        tableView2.backgroundColor = UIColor.clearColor()
        tableView2.tableHeaderView = headerView2
        tableView2.sendSubviewToBack(headerView2)
        tableView2.registerNib(UINib(nibName: "UserRankCell",bundle: nil), forCellReuseIdentifier: "UserRankCell")
        
        //3
        tableView3.tableHeaderView = headerView3
        tableView3.backgroundColor = UIColor.clearColor()
        tableView3.sendSubviewToBack(headerView3)
        tableView3.registerNib(UINib(nibName: "UserRankCell",bundle: nil), forCellReuseIdentifier: "UserRankCell")
        
        tableView1.hidden = true
        tableView3.hidden = true
        tableView2.hidden = false
 //        headerView.hidden = false
 
        getData()
    }

    func getData() {
        UserDetailModel.getUserData(loginName) { (arrs, error) in
            if arrs != nil {
                self.headerView.model = arrs
                self.headerView1.model = arrs
                self.headerView2.model = arrs
                self.headerView3    .model = arrs

            }
        }
    }
 

    private lazy var headerView:UserDetailHeader = {
        let header = NSBundle.mainBundle().loadNibNamed("UserDetailHeader", owner: nil, options: nil).first as! UserDetailHeader
//        header.backgroundColor = U
        
        return header
    }()
    
    private lazy var headerView1:UserDetailHeader = {
        let header = NSBundle.mainBundle().loadNibNamed("UserDetailHeader", owner: nil, options: nil).first as! UserDetailHeader
        //        header.backgroundColor = U
        
        return header
    }()
    
    private lazy var headerView2:UserDetailHeader = {
        let header = NSBundle.mainBundle().loadNibNamed("UserDetailHeader", owner: nil, options: nil).first as! UserDetailHeader
        //        header.backgroundColor = U
        
        return header
    }()
    
    private lazy var headerView3:UserDetailHeader = {
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
        
        switch tableView {
        case tableView1:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
            return cell;
        case tableView2:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
            return cell;
        case tableView3:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
            return cell;
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
            return cell;
        }
        
    }
    
    
}