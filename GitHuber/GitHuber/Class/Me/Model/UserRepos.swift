//
//  UserRepos.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserRepos: NSObject {
    
    var id:Int=0
    var name:String?
    var full_name:String?
    var html_url:String?
    var descriptionStr:String?
    var language:String?
    var stargazers_count:Int=0

    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        //        print("key=:\(value),key=:\(key)")
        
        if "description" == key {
            descriptionStr = value as?String
        }
        
        super.setValue(value, forKey: key)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

    
    class func getRepos(url:String,finished:(arrs:[UserRepos]?,error:Any?)->()){
 
        APINetTools.getBase(url, params: nil, success: { (json) -> Void in
            print(json)
            let arr = json as! [[String:AnyObject]]
            
            var models = [UserRepos]()
            for dict in arr {
                models.append(UserRepos(dict: dict))
            }
            
            finished(arrs: models, error: nil)
        }) { (error) -> Void in
            print(error)
            finished(arrs: nil, error: error)
        }
    }

}
