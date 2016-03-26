//
//  RankViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {
    @IBOutlet weak var languageBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let chooseLanViewH:CGFloat = 300
    let refreshControl = UIRefreshControl()
    var dataArray:[RankUser]? = []
    //刷新相关
    var pullRefrefshFlag = false
    var currentPage:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(chooseLanView)
        chooseLanView.frame = CGRect(x: 0, y: -chooseLanViewH+40, width: self.view.frame.width, height: chooseLanViewH)
        
        view.addSubview(chooseCityView)
        chooseCityView.frame = CGRect(x: 0, y: -chooseLanViewH+40, width: self.view.frame.width, height: chooseLanViewH)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RankViewController.languageHadChoosed(_:)), name: "ChooseLanguageViewDidSelect", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RankViewController.cityHadChoosed(_:)), name: "ChooseCityViewDidSelect", object: nil)
        
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(RankViewController.getData), forControlEvents: .ValueChanged)
       begainRefre()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cityHadChoosed(notice:NSNotification) {
        let userInfo:String = (notice.userInfo!["chooseStr"] as? String)! ?? "beijing"
        cityBtn.setTitle(userInfo, forState: .Normal)
        begainRefre()
        chooseCity(self.languageBtn)
    }
    
    func languageHadChoosed(notice:NSNotification) {
        let userInfo:String = (notice.userInfo!["chooseStr"] as! String) ?? "swift"
        languageBtn .setTitle(userInfo, forState: .Normal)
        begainRefre()
        chooseLanguage(self.languageBtn)
    }
    
    func begainRefre() {
        refreshControl.beginRefreshing()
        currentPage = 1
        getData()
    }
    
    func getData() {
        let url = getUrl()
        APINetTools.get(url, params: nil, success: { (json) in
            self.refreshControl.endRefreshing()
            if self.pullRefrefshFlag == false{
                self.dataArray?.removeAll()
            }
            let dic = json as! [String:AnyObject]//json["items"] as Array
            
            let array = dic["items"] as?[[String:AnyObject]] ?? []//
        
            for arr in array{
                let user = RankUser(dict: arr)
                self.dataArray?.append(user)
            }
            self.tableView.reloadData()
            }) { (error) in
                print(error)
                self.refreshControl.endRefreshing()
        }
    }
    
    func getUrl() -> String{
        var url = ""
        let city = cityBtn.currentTitle!
        let language = languageBtn.currentTitle!
        if city == "City" && (language == "Language" || language == "All Languages"){//什么都没有选择
            url = "search/users?q=location:China&sort=followers&page=\(currentPage)"
        }else if(city != "City" && (language == "Language" || language == "All Languages")){//只有选择城市
             url = "search/users?q=location:\(city)&sort=followers&page=\(currentPage)"
        }else if(city == "City" && (language != "Language" && language != "All Languages")){//只有选择语言
            url = "search/users?q=language:\(language)&sort=followers&order=desc&page=\(currentPage)"
        }else if (city != "City" && (language != "Language" && language != "All Languages")){//选择城市语言
            url = "search/users?q=location:\(city)+language:\(language)&sort=followers&page=\(currentPage)"
        }else{
            url = "search/users?q=location:China&sort=followers&page=\(currentPage)"
        }
        url = (url as NSString) .stringByReplacingOccurrencesOfString(" ", withString: "%2B")
        print("url:\(url)")
        return url
    }
    
    
    
    @IBAction func chooseCity(sender: UIButton) {
        let duration = 0.5
        if !chooseCityView.isChooseLanShowing  {
            UIView.animateWithDuration(duration, animations: {
                self.chooseCityView.isChooseLanShowing = true
                self.chooseCityView.transform = CGAffineTransformMakeTranslation(0, self.chooseLanViewH+40+20)
                self.tableView.scrollEnabled = false
                self.languageBtn.enabled = false
            })
        }else{
            UIView.animateWithDuration(duration, animations: {
                self.chooseCityView.isChooseLanShowing = false
                self.chooseCityView.transform = CGAffineTransformIdentity
                self.tableView.scrollEnabled = true
                self.languageBtn.enabled = true
            })
        }
    }
    @IBAction func chooseLanguage(sender: UIButton) {
        let duration = 0.5
        if !chooseLanView.isChooseLanShowing  {
            UIView.animateWithDuration(duration, animations: {
                self.chooseLanView.isChooseLanShowing = true
                self.chooseLanView.transform = CGAffineTransformMakeTranslation(0, self.chooseLanViewH+40+20)
                self.tableView.scrollEnabled = false
                self.cityBtn.enabled = false
            })
        }else{
            UIView.animateWithDuration(duration, animations: {
                self.chooseLanView.isChooseLanShowing = false
                self.chooseLanView.transform = CGAffineTransformIdentity
                self.tableView.scrollEnabled = true
                self.cityBtn.enabled = true
            })
        }
    }
    
    //MARK --  懒加载
    private let chooseLanView:ChooseLanguageView = {
        let chooseLanView = NSBundle.mainBundle().loadNibNamed("ChooseLanguageView", owner: nil, options: nil).first as! ChooseLanguageView
        return chooseLanView
    }()
    
    private let chooseCityView:ChooseCityView = {
        let choosetCity = NSBundle.mainBundle().loadNibNamed("ChooseCityView", owner: nil, options: nil).first as! ChooseCityView
        return choosetCity
    }()

    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension RankViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RankCell") as! RankCell
        cell.model = self.dataArray![indexPath.row]
        cell.rankNum = indexPath.row
        
        //判断是否滚到了最后一个cell
        let count = dataArray?.count ?? 0
        if indexPath.row == (count - 1) {
           print("load more more");
            pullRefrefshFlag = true
            currentPage += 1
            getData()
        }
        
        return cell;
    }
    
    
}











