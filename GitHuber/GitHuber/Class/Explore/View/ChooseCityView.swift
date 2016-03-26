//
//  ChoosetCityView.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ChooseCityView: UIView {
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var tableview2: UITableView!
    var isChooseLanShowing:Bool = false
    
    let dataArray1:[String] = ["USA","UK","Germany","China","Canada","India","France","Australia","Other"];
    var dataArray2:[String] = ["San Francisco","New York","Seattle","Chicago","Los Angeles","Boston","Washington","San Diego","San Jose","Philadelphia"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableview1.separatorStyle = .None
        tableview1.registerNib(UINib(nibName: "ChooseLanguageCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ChLanguageCell")
        tableview2.separatorStyle = .None
        tableview2.registerNib(UINib(nibName: "ChooseLanguageCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ChLanguageCell")
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        tableview1.reloadData()
 
        
        let path = NSIndexPath(forRow: 0, inSection: 0)
        tableview1.selectRowAtIndexPath(path, animated: true, scrollPosition: .Bottom)
        tableview2.reloadData()
    }
    
    
    //    func chooseLanView
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    

}

extension ChooseCityView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableview1 {
            return dataArray1.count ?? 0;
        }else{
            return dataArray2.count ?? 0;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :ChooseLanguageCell = tableView.dequeueReusableCellWithIdentifier("ChLanguageCell") as! ChooseLanguageCell
        if tableView == tableview1 {
            cell.titleLabel.text = dataArray1[indexPath.row]
        }else{
             cell.titleLabel.text = dataArray2[indexPath.row]
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if tableView == tableview1 {
            if indexPath.row == 0 {
                dataArray2 = ["San Francisco","New York","Seattle","Chicago","Los Angeles","Boston","Washington","San Diego","San Jose","Philadelphia"]
            }else if indexPath.row == 1 {
                dataArray2 = ["London","Cambridge","Manchester","Edinburgh","Bristol","Birmingham","Glasgow","Oxford","Newcastle","Leeds"];
            }else if indexPath.row == 2 {
                dataArray2 = ["Berlin","Munich","Hamburg","Cologne","Stuttgart","Dresden","Leipzig"]
            }else if indexPath.row == 3 {
                dataArray2 = ["beijing","shanghai","shenzhen","hangzhou","guangzhou","chengdu","nanjing","wuhan","suzhou","xiamen","tianjin","chongqing","changsha"];
            }else if indexPath.row == 4 {
                dataArray2 = ["Toronto","Vancouver","Montreal","ottawa","Calgary","Quebec"]
            }else if indexPath.row == 5 {
                dataArray2 = ["Chennai","Pune","Hyderabad","Mumbai","New Delhi","Noida","Ahmedabad","Gurgaon","Kolkata"]
            }else if indexPath.row == 6 {
                dataArray2 = ["paris","Lyon","Toulouse","Nantes"]
            }else if indexPath.row == 7 {
                dataArray2 = ["sydney","Melbourne","Brisbane","Perth"]
            }else if indexPath.row == 8 {
                dataArray2 = ["Tokyo","Moscow","Singapore","Seoul"]
            }else{ }
            tableview2.reloadData()
        }else if tableView == tableview2{
            let str = dataArray2[indexPath.row]
            NSNotificationCenter.defaultCenter().postNotificationName("ChooseCityViewDidSelect", object: nil, userInfo: ["chooseStr" : str])
        }
    }
    
}
