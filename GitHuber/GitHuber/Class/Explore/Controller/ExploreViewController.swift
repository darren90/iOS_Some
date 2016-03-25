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
        APINetTools.get("http://trending.codehub-app.com/v2/trending?since=weekly", params: nil, success: { (json) -> Void in
            print(json)
        }) { (error) -> Void in
            print(error)
        }
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
