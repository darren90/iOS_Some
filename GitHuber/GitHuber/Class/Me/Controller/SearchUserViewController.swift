//
//  SearchUserViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataArray:[SearchUserModel]! = []
    let label = UILabel()
    var currentPage :Int = 1
    var pullRefrefshFlag = false
    var KeyText = ""
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "SearchUserCell",bundle:nil), forCellReuseIdentifier: "SearchUserCell")
        tableView.rowHeight = 80

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchUserViewController.begainSearch(_:)), name: "SearchBegainSearch", object: nil)
        

        label.frame = CGRect(x: view.frame.width - 110, y: 10, width: 100, height: 20)
        label.backgroundColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = KCommonColor
        view.addSubview(label)
        label.sizeToFit()
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(SearchUserViewController.getPull), forControlEvents: .ValueChanged)
    }
    
    
    func begainSearch(notice:NSNotification)  {
       let keyword = notice.userInfo!["SearchKeyWord"] as! String
        KeyText = keyword
        getData(keyword)
    }
    
    func getPull() {
        getData(KeyText)
    }
    
    
    func getData(keyword: String) {
        if self.pullRefrefshFlag == false{
            refreshControl.beginRefreshing()
        }
        
        let keywords = keyword + "&page=\(currentPage)"
        SearchUserModel.getSearchUserList(keywords) { (arrs,totalCount, error) in
            self.refreshControl.endRefreshing()
            
            self.label.text = "Count:" + String(totalCount)
            
            if self.pullRefrefshFlag == false{
                self.dataArray?.removeAll()
            }
            
            for arr in arrs!{
                self.dataArray.append(arr)
            }
            
            self.tableView.reloadData()
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


extension SearchUserViewController:UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
    }
    
    //MARK - tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchUserCell") as! SearchUserCell
        cell.model = self.dataArray[indexPath.row]
        
        //判断是否滚到了最后一个cell
        let count = dataArray?.count ?? 0
        if indexPath.row == (count - 1) {
            print("load more more");
            pullRefrefshFlag = true
            currentPage += 1
            getData(KeyText)
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.dataArray[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserWebInfo") as! UserWebInfoViewController
        vc.title = model.login
        vc.webUrl = model.html_url
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}





