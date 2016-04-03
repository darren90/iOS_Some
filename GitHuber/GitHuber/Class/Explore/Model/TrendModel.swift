//
//  TrendModel.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TrendModel: NSObject {
    
    var id:Int = 0
    var name:String?
    var html_url:String?
    var descriptionStr:String?
    var language:String?
    var stargazers_count:Int = 0
    var owner:Owner?
    var url:String?
    
    
    //为了字典转模型
    init(dict:[String:AnyObject]){
        super.init()//用需要调用 super
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        //        print("key=:\(value),key=:\(key)")
        
        if "description" == key {
            descriptionStr = value as?String
        }
        
        if "owner" == key {
            owner = Owner(dict: value as! [String:AnyObject] )
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
    
    
    class func getTrends(tailUrl:String,finished:(arrs:[TrendModel]?,error:Any?)->()) {
//        http://trending.codehub-app.com/v2/trending?since=weekly
        let url = "http://trending.codehub-app.com/v2/trending?" + tailUrl
        APINetTools.get(url, params: nil, success: { (json) -> Void in
//            print(json)
            let arr = dict2Model(json as! [[String:AnyObject]])
//            print(arr)
            finished(arrs: arr,error:nil)
        }) { (error) -> Void in
//            print(error)
            finished(arrs: nil,error:error)
        }

    }
    
    class func dict2Model(list:[[String:AnyObject]]) -> [TrendModel]{
        var models = [TrendModel]()
        for dict in list {
            models.append(TrendModel(dict: dict))
        }
        return models
    }
    
    
 
    // Searh Repos
    
    class func getSearch(keyWord:String,finished:(arrs:[TrendModel]?,totalCount:Int,error:Any?)->()){
        APINetTools.get(keyWord, params: nil, success: { (json) -> Void in
            let count = json["total_count"] as? Int ?? 0
            let arr = dict2Model(json["items"] as! [[String:AnyObject]])
            //            print(arr)
            finished(arrs: arr,totalCount:count,error:nil)
        }) { (error) -> Void in
            //            print(error)
            finished(arrs: nil,totalCount:0,error:error)
        }
    }
    
    
}
