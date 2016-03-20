//
//  TFCommon.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


public let KRandomColor = UIColor.init(colorLiteralRed: Float(arc4random_uniform(256))/255.0, green: Float(arc4random_uniform(256))/255.0, blue: Float(arc4random_uniform(256))/255.0, alpha: 1.0)


public func KColor(r:Int,g:Int,b:Int) -> UIColor{
    return UIColor.init(colorLiteralRed: Float(r)/255.0, green: Float(g)/255.0, blue: Float(b)/255.0, alpha: 1.0)
}

public let KBasePlayUrl = "http://127.0.0.1:12345"


//友盟
public let KAppid = "56ee9ee467e58e3b2500035e"


public let KHeight = UIScreen.mainScreen().bounds.height
public let KWidth = UIScreen.mainScreen().bounds.width



