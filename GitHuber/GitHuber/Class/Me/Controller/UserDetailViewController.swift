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
    //@IBOutlet weak var tableView2: UITableView!
    //@IBOutlet weak var tableView3: UITableView!
    
    var swipeVC:UserDetailRKSwipeController!
    var headerViewH:CGFloat  = 150.0
    
    var dataArray:[UserRepos]! = []
    
    //外界传递的参数
    var loginName:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70
        
        let name = NSUserDefaults.standardUserDefaults().objectForKey("GitHubName") as? String
        if name != nil {
            headerViewH = 120
        }
        let headerRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: headerViewH)
        headerView.frame = headerRect
 
        //1
        tableView.tableHeaderView = headerView
        
        getData()
    }

    func getData() {
        UserDetailModel.getUserData(loginName) { (arrs, error) in
            if arrs != nil {
                self.headerView.model = arrs
                self.getRepos(arrs!.repos_url!)
            }
        }
    }
    
    func getRepos(url:String)  {
       UserRepos .getRepos(url) { (arrs, error) in
            if arrs != nil {
                self.dataArray = arrs
                self.tableView.reloadData()
//                print(arrs);
                
            }
        }

    }
 

    func initmYSlideView(){
        swipeVC = UserDetailRKSwipeController()
        self.view.addSubview(swipeVC.view)
        self.addChildViewController(swipeVC)
        
        swipeVC.view.backgroundColor = UIColor.redColor()
        swipeVC.view.frame = CGRect(x: 0, y:300, width: KWidth, height: KHeight-300)
        view.bringSubviewToFront(swipeVC.view)
    }
    
    private lazy var headerView:UserDetailHeader = {
        let header = NSBundle.mainBundle().loadNibNamed("UserDetailHeader", owner: nil, options: nil).first as! UserDetailHeader
//        header.backgroundColor = U
        
        return header
    }()
 
    
   
}


extension UserDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    //MARK - tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count ?? 0;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        switch tableView {
//        case tableView1:
//            let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
//            return cell;
//        case tableView2:
//            let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
//            return cell;
//        case tableView3:
//            let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
//            return cell;
//        default:
//            let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
//            return cell;
//        }
        let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
        cell.model = self.dataArray[indexPath.row]

        return cell;
    }
    
    //MARK - DLTabedSlideViewDelegate
    
 
    
}