//
//  UserFollow.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserFollow: NSObject {
    
    var login:String?
    var avatar_url:String?
    var url:String?
    var html_url:String?
    
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
    class func getFollowers(url:String,finished:(arrs:[UserFollow]?,error:Any?)->()){
        APINetTools.getBase(url, params: nil, success: { (json) -> Void in
            print(json)
            let arr = json as! [[String:AnyObject]]
            
            var models = [UserFollow]()
            for dict in arr {
                models.append(UserFollow(dict: dict))
            }
            
            finished(arrs: models, error: nil)
        }) { (error) -> Void in
            print(error)
            finished(arrs: nil, error: error)
        }
    }
    
    //粉丝
    class func getFollowing(url:String,finished:(arrs:[UserFollow]?,error:Any?)->()){
        APINetTools.getBase(url, params: nil, success: { (json) -> Void in
            print(json)
            let arr = json as! [[String:AnyObject]]
            
            var models = [UserFollow]()
            for dict in arr {
                models.append(UserFollow(dict: dict))
            }
            
            finished(arrs: models, error: nil)
        }) { (error) -> Void in
            print(error)
            finished(arrs: nil, error: error)
        }
    }


}
//login: "ganghuaChen",
//id: 5681271,
//avatar_url: "https://avatars.githubusercontent.com/u/5681271?v=3",
//gravatar_id: "",
//url: "https://api.github.com/users/ganghuaChen",
//html_url: "https://github.com/ganghuaChen",
//followers_url: "https://api.github.com/users/ganghuaChen/followers",
//following_url: "https://api.github.com/users/ganghuaChen/following{/other_user}",
//gists_url: "https://api.github.com/users/ganghuaChen/gists{/gist_id}",
//starred_url: "https://api.github.com/users/ganghuaChen/starred{/owner}{/repo}",
//subscriptions_url: "https://api.github.com/users/ganghuaChen/subscriptions",
//organizations_url: "https://api.github.com/users/ganghuaChen/orgs",
//repos_url: "https://api.github.com/users/ganghuaChen/repos",
//events_url: "https://api.github.com/users/ganghuaChen/events{/privacy}",
//received_events_url: "https://api.github.com/users/ganghuaChen/received_events",
//type: "User",
//site_admin: false