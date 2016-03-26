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
    
//    private let choosetViewW:CGFloat = 160
    private let chooseLanViewH:CGFloat = 300

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(chooseLanView)
        chooseLanView.frame = CGRect(x: 0, y: -chooseLanViewH+40, width: self.view.frame.width, height: chooseLanViewH)
        
        view.addSubview(chooseCityView)
        chooseCityView.frame = CGRect(x: 0, y: -chooseLanViewH+40, width: self.view.frame.width, height: chooseLanViewH)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RankViewController.languageHadChoosed(_:)), name: "ChooseLanguageViewDidSelect", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(RankViewController.cityHadChoosed(_:)), name: "ChooseCityViewDidSelect", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cityHadChoosed(notice:NSNotification) {
        let userInfo:String = (notice.userInfo!["chooseStr"] as? String)!
        cityBtn.setTitle(userInfo, forState: .Normal)
        chooseCity(self.languageBtn)
    }
    
    func languageHadChoosed(notice:NSNotification) {
        let userInfo:String = (notice.userInfo!["chooseStr"] as? String)!
        languageBtn .setTitle(userInfo, forState: .Normal)
        chooseLanguage(self.languageBtn)
    }
    
    @IBAction func chooseCity(sender: UIButton) {
        let duration = 0.5
        if !chooseCityView.isChooseLanShowing  {
            UIView.animateWithDuration(duration, animations: {
                self.chooseCityView.isChooseLanShowing = true
                self.chooseCityView.transform = CGAffineTransformMakeTranslation(0, self.chooseLanViewH+40+20)
                self.tableView.scrollEnabled = false
            })
        }else{
            UIView.animateWithDuration(duration, animations: {
                self.chooseCityView.isChooseLanShowing = false
                self.chooseCityView.transform = CGAffineTransformIdentity
                self.tableView.scrollEnabled = true
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
            })
        }else{
            UIView.animateWithDuration(duration, animations: {
                self.chooseLanView.isChooseLanShowing = false
                self.chooseLanView.transform = CGAffineTransformIdentity
                self.tableView.scrollEnabled = true
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











