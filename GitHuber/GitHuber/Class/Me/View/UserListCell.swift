//
//  UserListCell.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var laugLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model:UserRepos?{
        didSet{
            self.titleLabel.text = model?.name
            self.subTitleLabel.text = model?.descriptionStr
            self.laugLabel.text = model?.language
            self.starCountLabel.text = String(model!.stargazers_count)
        }
    }

}
