//
//  SearchReposViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SearchReposViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:[TrendModel]! = []
    let label = UILabel()
    var currentPage :Int = 1
    var pullRefrefshFlag = false
    var KeyText = ""
    let refreshControl = UIRefreshControl()
    
//    &page=0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "SearchRepoCell",bundle:nil), forCellReuseIdentifier: "SearchRepoCell")
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
    
//    https://api.github.com/search/repositories?q=darr&sort=stars&order=desc&page=10
    func getData(keyword: String) {
        if self.pullRefrefshFlag == false{
            refreshControl.beginRefreshing()
        }
        
        let keywords = "search/repositories?q=\(keyword)&sort=stars&order=desc" + "&page=\(currentPage)"
        
        TrendModel.getSearch(keywords) { (arrs,totalCount, error) in
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

extension SearchReposViewController:UITableViewDelegate,UITableViewDataSource{
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchRepoCell") as! SearchRepoCell
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
        vc.title = model.owner!.login
        vc.webUrl = model.html_url
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}


