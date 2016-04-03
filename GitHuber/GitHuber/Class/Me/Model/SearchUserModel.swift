//
//  SearchUserModel.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class SearchUserModel: NSObject {
    var login:String?
    var avatar_url:String?
    var html_url:String?
    var score:Float = 0.01
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //    override func setValue(value: AnyObject?, forKey key: String) {
    //        //        print("key=:\(value),key=:\(key)")
    //        if "description" == key {
    //            descriptionStr = value as?String
    //        }
    //        super.setValue(value, forKey: key)
    //    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

    
    //跟随者
    class func getSearchUserList(keyword:String,finished:(arrs:[SearchUserModel]?,totalCount:Int,error:Any?)->()){
        APINetTools.get("search/users?q="+keyword, params: nil, success: { (json) -> Void in
            let arr = json["items"] as! [[String:AnyObject]]
            let count = json["total_count"] as? Int ?? 0
            var models = [SearchUserModel]()
            for dict in arr {
                models.append(SearchUserModel(dict: dict))
            }
            
            finished(arrs: models,totalCount: count, error: nil)
        }) { (error) -> Void in
            print(error)
            finished(arrs: nil,totalCount: 0,error: error)
        }
    }
    

    
    
}
