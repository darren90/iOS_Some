//
//  ExploreCell.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

class ExploreCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
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
    
    var rankNum:Int?{
        didSet{
            self.rankLabel.text = String(rankNum!+1) ?? "1"
        }
    }
    
    var model:TrendModel?{
        didSet{
//            NSURL(String)
//            NSURL(string: )
//            print(String(model!.stargazers_count))
            self.iconView .sd_setImageWithURL(NSURL(string: (model?.owner!.avatar_url)!), completed: nil)
            self.nameLabel.text = model?.name
            self.authorLabel.text = "\(model!.language ??  "")\(model!.owner!.login ??  "")"
            self.starCount .setTitle(String(model!.stargazers_count) ?? "0", forState: .Normal)
            self.descLabel.text = model?.descriptionStr
        }
    }

}
