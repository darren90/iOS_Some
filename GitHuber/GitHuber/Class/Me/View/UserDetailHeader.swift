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
 
    @IBOutlet weak var reoBtn: UIView!
    @IBOutlet weak var followingBtn: UIView!
    @IBOutlet weak var followerBtn: UIView!
    

    override func awakeFromNib() {
        reoBtn.addSubview(reoBtnView)
        reoBtnView.frame = reoBtn.bounds
        
        followingBtn.addSubview(followingBtnView)
        followingBtnView.frame = followingBtn.bounds
        
        followerBtn.addSubview(followerBtnView)
        followerBtnView.frame = followerBtn.bounds
        
    }
    
    var model:UserDetailModel?{
        didSet{
            iconView.sd_setImageWithURL(NSURL(string: (model?.avatar_url)!), placeholderImage: KPlaceholderImg)
            nameLabel.text = model?.name
            nikeNameLabel.text = model?.login
            locationLabel.text = model?.location
            emailLabel.text = model?.email
            
            
            reoBtnView.textBtn.setTitle("Repositories", forState: .Normal)
            followingBtnView.textBtn.setTitle("Following", forState: .Normal)
            followerBtnView.textBtn.setTitle("Follower", forState: .Normal)

            //三个btn的设置
            reoBtnView.numBtn.setTitle("\(model!.public_repos)", forState: .Normal)
            followingBtnView.numBtn.setTitle("\(model!.following)", forState: .Normal)
            followerBtnView.numBtn.setTitle("\(model!.followers)", forState: .Normal)
        }
    }
    
    lazy var reoBtnView :UserButton = {
        let view = NSBundle.mainBundle().loadNibNamed("UserButton", owner: nil, options: nil).first as! UserButton!
        return view
    }()
    var followingBtnView :UserButton = {
        let view = NSBundle.mainBundle().loadNibNamed("UserButton", owner: nil, options: nil).first as! UserButton!
        return view
    }()
    var followerBtnView :UserButton = {
        let view = NSBundle.mainBundle().loadNibNamed("UserButton", owner: nil, options: nil).first as! UserButton!
        return view
    }()
    
}
