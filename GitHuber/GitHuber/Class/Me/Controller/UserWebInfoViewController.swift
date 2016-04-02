//
//  UserWebInfoViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/4/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserWebInfoViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    
    var webUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: webUrl)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
}


extension UserWebInfoViewController:UIWebViewDelegate{
    func webViewDidFinishLoad(webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("didFailLoadWithError")

    }
}

