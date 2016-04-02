//
//  UserButton.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserButton: UIView {
    @IBOutlet weak var numBtn: UIButton!
    @IBOutlet weak var textBtn: UIButton!

    
    override func awakeFromNib() {
        numBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        textBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
 
        numBtn.setTitleColor(KCommonColor, forState: .Highlighted)
        textBtn.setTitleColor(KCommonColor, forState: .Highlighted)
        
        numBtn.setTitleColor(KCommonColor, forState: .Selected)
        textBtn.setTitleColor(KCommonColor, forState: .Selected)
    }

    func userBtnDidClick(userBtn:UserButton) {
        
    }
    
    @IBAction func touchDown(sender: UIButton) {
//        sender.selected = !sender.selected
    }
  
}
