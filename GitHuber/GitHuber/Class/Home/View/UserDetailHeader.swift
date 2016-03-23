//
//  UserDetailHeader.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserDetailHeader: UIView {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nikeNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
        
    }

}
