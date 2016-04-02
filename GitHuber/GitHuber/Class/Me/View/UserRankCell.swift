//
//  UserRankCell.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserRankCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var model:UserFollow?{
        didSet{
            self.iconView.sd_setImageWithURL(NSURL(string: (model?.avatar_url!)!), placeholderImage: KPlaceholderImg)
            self.nameLabel.text = model?.login
        }
    }
    
    var rankNum:Int?{
        didSet{
            self.rankLabel.text = String(rankNum!+1) ?? "1"
        }
    }
    
}
