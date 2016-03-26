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
    @IBOutlet weak var tableView: UITableView!
    
    //外界传递的参数
    var loginName:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70
        // Do any additional setup after loading the view.
//        view.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 140)
        tableView.tableHeaderView = headerView
//        tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
//        headerView.snp_makeConstraints { (make) in
//            make.width.height.equalTo(100)
//        }
        
        
        getData()
    }

    func getData() {
        UserDetailModel.getUserData(loginName) { (arrs, error) in
            if arrs != nil {
                self.headerView.model = arrs
            }
        }
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