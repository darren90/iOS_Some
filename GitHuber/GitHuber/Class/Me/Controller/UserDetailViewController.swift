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
    
    var repoArray:[UserRepos]! = []
    var followingArray:[UserFollow]! = []
    var followerArray:[UserFollow]! = []

    
    //外界传递的参数
    var loginName:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 70
        
        tableView.registerNib(UINib(nibName: "UserRankCell",bundle:nil), forCellReuseIdentifier: "UserRankCell")
        
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
                self.getFollowing(arrs!.following_url_!)
                self.getFollower(arrs!.followers_url!)
            }
        }
    }
    
    func getRepos(url:String)  {
       UserRepos .getRepos(url) { (arrs, error) in
            if arrs != nil {
                self.repoArray = arrs
                self.tableView.reloadData()
//                print(arrs);
                
            }
        }
    }
    
    func getFollowing(url:String)  {
        if followingArray == nil || followingArray.count == 0 {
            UserFollow.getFollowing(url) { (arrs, error) in
                self.followingArray = arrs
                self.tableView.reloadData()
            }
        }
    }
 
    func getFollower(url:String)  {
        if followerArray == nil || followerArray.count == 0 {
            UserFollow.getFollowers(url) { (arrs, error) in
                self.followerArray = arrs
                self.tableView.reloadData()
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
        header.delegate  = self
        return header
    }()
}


extension UserDetailViewController:UITableViewDelegate,UITableViewDataSource,UserDetailHeaderDelegate{
    
    //MARK - tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(headerView.headerType)
        switch headerView.headerType {
        case .Repo:
            return repoArray.count ?? 0;
        case .Following:
            return followingArray.count ?? 0;
        case .Follower:
            return followerArray.count ?? 0;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch headerView.headerType {
        case .Repo:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserList") as! UserListCell
            if repoArray.count != 0 {
                cell.model = self.repoArray[indexPath.row]
            }
            return cell;
        case .Following:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
            if followingArray.count != 0 {
                cell.model = followingArray[indexPath.row]
                cell.rankNum = indexPath.row
            }
            return cell;
        case .Follower:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserRankCell") as! UserRankCell
            if followerArray.count != 0 {
                cell.model = followerArray [indexPath.row]
                cell.rankNum = indexPath.row
            }
            return cell;
        }
    }
    
    //MARK - DLTabedSlideViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.repoArray[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserWebInfo") as! UserWebInfoViewController
        vc.title = model.name
        vc.webUrl = model.html_url
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    func didHeaderClick(headerType: HeaderBtnType) {
        switch headerType {
        case .Repo:
            
            tableView.reloadData()
            break
        case .Following:
            
            tableView.reloadData()
            break
        case .Follower:
            
            tableView.reloadData()
            break
        default: break
        }
    }
}