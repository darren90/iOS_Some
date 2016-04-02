//
//  UserDetailHeader.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

enum HeaderBtnType {
    case Repo
    case Following
    case Follower
}

//Swift
protocol UserDetailHeaderDelegate: NSObjectProtocol{
    func didHeaderClick(headerType:HeaderBtnType)
}


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
    
    ///定义一个属性保存代理对象
    //加上weak。避免虚幻引用
    weak var delegate:UserDetailHeaderDelegate?

    override func awakeFromNib() {
        reoBtn.addSubview(reoBtnView)
        reoBtnView.frame = reoBtn.bounds
        
        followingBtn.addSubview(followingBtnView)
        followingBtnView.frame = followingBtn.bounds
        
        followerBtn.addSubview(followerBtnView)
        followerBtnView.frame = followerBtn.bounds
        
        //
        reoBtnView.textBtn.setTitle("Repositories", forState: .Normal)
        followingBtnView.textBtn.setTitle("Following", forState: .Normal)
        followerBtnView.textBtn.setTitle("Follower", forState: .Normal)
        
        addTarget(reoBtnView)
        addTarget(followingBtnView)
        addTarget(followerBtnView)
    }
    
    func  addTarget(btn:UserButton)  {
        btn.numBtn.addTarget(self, action: #selector(UserDetailHeader.buttonDidClick(_:)), forControlEvents: .TouchDown)
        btn.textBtn.addTarget(self, action: #selector(UserDetailHeader.buttonDidClick(_:)), forControlEvents: .TouchDown)
    }
    
    var model:UserDetailModel?{
        didSet{
            iconView.sd_setImageWithURL(NSURL(string: (model?.avatar_url)!), placeholderImage: KPlaceholderImg)
            nameLabel.text = model?.name
            nikeNameLabel.text = model?.login
            locationLabel.text = model?.location
            emailLabel.text = model?.email


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
    
    
    
    func buttonDidClick(btn:UIButton)  {
        if btn.superview == reoBtnView{
            reoBtnView.numBtn.selected = true
            reoBtnView.textBtn.selected = true
            
            followingBtnView.numBtn.selected = false
            followingBtnView.textBtn.selected = false
            
            followerBtnView.numBtn.selected = false
            followerBtnView.textBtn.selected = false
            
            delegate?.didHeaderClick(.Repo)
        }else if btn.superview == followingBtnView{
            followingBtnView.numBtn.selected = true
            followingBtnView.textBtn.selected = true
            
            reoBtnView.numBtn.selected = false
            reoBtnView.textBtn.selected = false
            
            followerBtnView.numBtn.selected = false
            followerBtnView.textBtn.selected = false
            
             delegate?.didHeaderClick(.Following)
        }else if btn.superview == followerBtnView{
            followerBtnView.numBtn.selected = true
            followerBtnView.textBtn.selected = true
            
            followingBtnView.numBtn.selected = false
            followingBtnView.textBtn.selected = false
            
            reoBtnView.numBtn.selected = false
            reoBtnView.textBtn.selected = false
            
            delegate?.didHeaderClick(.Follower)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
