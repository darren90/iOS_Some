//
//  ExploreViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

//https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc

//daily  weekly  monthly

//http://trending.codehub-app.com/v2/trending?since=weekly&language=objective-c

//http://trending.codehub-app.com/v2/trending?since=weekly
class ExploreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let choosetViewW:CGFloat = 160
    var dataArray:[TrendModel]?{
        didSet{//设置完毕数据，就刷新表格
            tableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(chooseView)
        chooseView.frame = CGRect(x: -choosetViewW, y: 64, width: choosetViewW, height: self.view.frame.height-64)
        
 
//        print(UIScreen.mainScreen().bounds)
//        print(self.view.frame)
//        print(tableView.frame)
        getData()
    }
 
    
    func getData() {
        
        TrendModel.getTrends("since=weekly") { (arrs, error) in
//            print(arrs)
            self.dataArray = arrs
        }
        
//        APINetTools.get("http://trending.codehub-app.com/v2/trending?since=weekly", params: nil, success: { (json) -> Void in
//            print(json)
//        }) { (error) -> Void in
//            print(error)
//        }
    }
    
    @IBAction func chooseLanguage(sender: UIBarButtonItem) {
        let duration = 0.5
        if !chooseView.isChooseLanShowing  {
            UIView.animateWithDuration(duration, animations: {
                self.chooseView.isChooseLanShowing = true
                self.chooseView.transform = CGAffineTransformMakeTranslation(self.choosetViewW, 0)
            })
        }else{
            UIView.animateWithDuration(duration, animations: {
                self.chooseView.isChooseLanShowing = false
                self.chooseView.transform = CGAffineTransformIdentity
            })
            
        }
    }
    
    
    
    //MARK --  懒加载
    private let chooseView:ChooseLanguageView = {
        let chooseLanView = NSBundle.mainBundle().loadNibNamed("ChooseLanguageView", owner: nil, options: nil).first as! ChooseLanguageView
//        chooseLanView.frame = CGRect(x: 0, y: 20, width: 100, height: self.view.frame.height)
        return chooseLanView
    }()
}
//
extension ExploreViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Explorecellcell") as! ExploreCell
        cell.model = self.dataArray![indexPath.row]
        cell.rankNum = indexPath.row
        return cell;
    }
    
    
}






