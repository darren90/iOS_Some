//
//  SearchRepoCell.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SearchRepoCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var starCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model:TrendModel?{
        didSet{
            self.iconView .sd_setImageWithURL(NSURL(string: (model?.owner!.avatar_url)!), placeholderImage: UIImage(named: "login_me_user-no"))
            self.nameLabel.text = model?.name
            self.authorLabel.text = "\(model!.language ??  "")/\(model!.owner!.login ??  "")"
            self.starCount .setTitle(String(model!.stargazers_count) ?? "0", forState: .Normal)
            self.descLabel.text = model?.descriptionStr
        }
    }
    
}
