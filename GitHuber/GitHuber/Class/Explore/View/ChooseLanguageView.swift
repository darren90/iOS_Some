//
//  ChooseLanguageView.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ChooseLanguageView: UIView {
    @IBOutlet weak var tableView: UITableView!
    var isChooseLanShowing:Bool = false

    let dataArray:[String] = ["All Languages","JavaScript","Java","PHP","Ruby","Python","CSS","CPP","C","Objective-C","Swift","Shell","R","Perl","Lua","HTML","Scala","Go"];
  
    override init(frame: CGRect) {
        super.init(frame: frame)
   
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.separatorStyle = .None
        tableView.registerNib(UINib(nibName: "ChooseLanguageCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ChLanguageCell")
    }

    
    
//    func chooseLanView 
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}


extension ChooseLanguageView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :ChooseLanguageCell = tableView.dequeueReusableCellWithIdentifier("ChLanguageCell") as! ChooseLanguageCell
        cell.titleLabel.text = dataArray[indexPath.row]
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let str = dataArray[indexPath.row]
        NSNotificationCenter.defaultCenter() .postNotificationName("ChooseLanguageViewDidSelect", object: nil, userInfo: ["chooseStr" : str])
    }
    
}



//    if (_languageEntranceType==RepLanguageEntranceType) {
//    languages=@[@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"CPP",@"C",@"Objective-C",@"Swift",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
//    }else if (_languageEntranceType==UserLanguageEntranceType  ) {
//    languages=@[NSLocalizedString(@"all languages", @""),@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"CPP",@"C",@"Objective-C",@"Swift",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
//    }else if (_languageEntranceType==TrendingLanguageEntranceType ) {
//    languages=@[NSLocalizedString(@"all languages", @""),@"javascript",@"java",@"php",@"ruby",@"python",@"css",@"cpp",@"c",@"objective-c",@"swift",@"shell",@"r",@"perl",@"lua",@"html",@"scala",@"go"];
//    }
