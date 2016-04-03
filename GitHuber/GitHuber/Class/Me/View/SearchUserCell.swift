//
//  SearchUserCell.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SearchUserCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model:SearchUserModel?{
        didSet{
            iconView.sd_setImageWithURL(NSURL(string: model!.avatar_url!), placeholderImage: KPlaceholderImg)
            nameLabel.text = model?.login
            subTitleLabel.text = "Score:" + String(model!.score) ?? "0.0"
        }
    }
    
}
