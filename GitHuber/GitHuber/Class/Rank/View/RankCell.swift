//
//  RankCell.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

class RankCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        iconView.layer.cornerRadius = 5
        iconView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var rankNum:Int?{
        didSet{
            self.rankLabel.text = String(rankNum!+1) ?? "1"
        }
    }
    
    var model:RankUser?{
        didSet{
//            rankLabel.text = 
            iconView.sd_setImageWithURL(NSURL(string: (model?.avatar_url)!), placeholderImage: UIImage(named: "login_me_user-no"))
            nameLabel.text = model?.login
        }
    }
    

}
