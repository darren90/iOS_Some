//
//  EventModel.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/26.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class EventModel: NSObject {
    var id:String?
    var type:String?
    var actor:[EventActor]?
    var repo:[EventRepo]?
    var payload:[EventPayload]?
    var created_at:String?
    
    
}
