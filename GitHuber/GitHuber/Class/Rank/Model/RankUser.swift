//
//  RankUser.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class RankUser: NSObject {

    var login:String?
    var id:Int = 0
    var avatar_url:String?
    var html_url:String?
    
    // 字典转模型
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
