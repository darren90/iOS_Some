//
//  UserDetailModel.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserDetailModel: NSObject {
    var login:String?
    var id:Int = 0
    var avatar_url:String?
    var url:String?
    var html_url:String?
//    var followers_url:String?
//    var following_url:String?
    var events_url:String?
    var name:String?
    var blog:String?
    var location:String?
    var email:String?
    var public_repos:Int = 0
    var public_gists:Int = 0
    var followers:Int = 0
    var following:Int = 0
    
    var repos_url:String?//repos url
    var following_url:String?//following
    var followers_url:String?//follwers
    
    var following_url_:String?//following
    
    var created_at:String?{
        didSet{
            let create = created_at! as NSString
            created_at = create.substringWithRange(NSMakeRange(0, 10))
        }
    }
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if "following_url" == key {
            let vv = value as? String ?? ""
     
            let xx = (vv as NSString).stringByReplacingOccurrencesOfString("{/other_user}", withString: "?page=1")
            following_url_ = xx
            print(xx)
            print(following_url_)
//            following_url = value as?String
        }
        super.setValue(value, forKey: key)
    }
    
    
    class func getUserData(loginName:String,finished:(arrs:UserDetailModel?,error:Any?)->()){
        var name = loginName
        if loginName == "" {
            name = "darren90"
        }
        APINetTools.get("users/\(name)", params: nil, success: { (json) -> Void in
            print(json)
            let arr = json as! [String:AnyObject]
            let model = UserDetailModel(dict: arr)
            finished(arrs: model, error: nil)
        }) { (error) -> Void in
            print(error)
             finished(arrs: nil, error: error)
        }
    }
    
}
