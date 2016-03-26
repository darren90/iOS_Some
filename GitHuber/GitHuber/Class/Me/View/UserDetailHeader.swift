//
//  UserDetailHeader.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailHeader: UIView {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nikeNameLabel: UILabel!
//    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var followBtn: UIButton!
 
    
    override func awakeFromNib() {
        
    }
    
    var model:UserDetailModel?{
        didSet{
            iconView.sd_setImageWithURL(NSURL(string: (model?.avatar_url)!), placeholderImage: KPlaceholderImg)
            nameLabel.text = model?.name
            nikeNameLabel.text = model?.login
            locationLabel.text = model?.location
            emailLabel.text = model?.email
            
        }
    }
    
    
    
}
