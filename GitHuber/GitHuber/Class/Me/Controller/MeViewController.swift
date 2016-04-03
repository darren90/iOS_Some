//
//  MeViewController.swift
//  GitHuber
//
//  Created by Tengfei on 16/3/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class MeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
   override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = KColor(250, g: 250, b: 250)
        return view
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = KColor(250, g: 250, b: 250)
        return view
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.section == 0{
            let loginName = getLoginName()
            if (loginName as NSString).length == 0 {
                showAlert()
            }else{
                enterUserDetail(loginName)
            }
        }else if indexPath.section == 1{ //用户的最近的动态
            let loginName = getLoginName()
            if (loginName as NSString).length == 0 {
                showAlert()
            }else{
                let userVc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserEvent") as! UserEventViewController;
                self.navigationController?.pushViewController(userVc, animated: true)
            }
        }else if indexPath.section == 2{//搜索
            let searVc = SearchSwipeViewController();
            self.navigationController?.pushViewController(searVc, animated: true)
        }else if indexPath.section == 3{//Setting
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("settingVc") as! SettingViewController
            self.navigationController!.pushViewController(vc, animated: true)
        }else if indexPath.section == 4{
            
        }
    }
    
    func isLogin() {
        
    }
    
    //进入用户的详情
    func enterUserDetail(loginName:String){
        let userVc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserDetail") as! UserDetailViewController;
        userVc.loginName = loginName
        self.navigationController?.pushViewController(userVc, animated: true)
    }

    
    func showAlert() {
        //        let alert = UIAlertView(title: "输入文字", message: "sdsdf", delegate: self, cancelButtonTitle: "cancle",otherButtonTitles:"确定")
        //        alert.show()
        let alertVc = UIAlertController(title: "Please Login GitHub LoginName ", message: nil, preferredStyle: .Alert)
        
        alertVc.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "GitHub LoginName,Not Email"
            textField.secureTextEntry = false
        }
        //add ok 
        let alertOk = UIAlertAction(title: "Sure", style: .Default) { (_) in
            let textField = alertVc.textFields!.first;
            let name = textField!.text ?? ""
            self.saveLoginName(name)
            self.enterUserDetail(name)
        }
        let alertCancle = UIAlertAction(title: "Cancle", style: .Cancel) { (_) in
            
        }
        alertVc.addAction(alertCancle)
        alertVc.addAction(alertOk)
        self .presentViewController(alertVc, animated: true, completion: nil)
    }
 
    
    func getLoginName() -> String{
        let name = NSUserDefaults.standardUserDefaults().objectForKey("GitHubName") as? String
        return name ?? ""
    }
    
    func saveLoginName(name:String)  {
        if (name as NSString).length == 0{return}
        
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: "GitHubName")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
//
 