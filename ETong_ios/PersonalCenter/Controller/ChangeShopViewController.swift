//
//  ChangeShopViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/11/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

typealias SingleInfoHand = (str :String) -> Void

class ChangeShopViewController: UIViewController {

    var changeInfo = UITextField()
    var str = String()
    var changeType = 0
    let helper = ETShopHelper()
    var myHandle:SingleInfoHand?
    var infoText = ""
    var strId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        self.title = "修改" + str
        
        addTextField()
        
        let rightButton = UIButton(type: .Custom)
        rightButton.frame = CGRectMake(0, 0, 50, 30)
        rightButton.setTitle("保存", forState: .Normal)
        rightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightButton.addTarget(self, action: #selector(rightBarButtonClicked), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }

    func addTextField(){
        changeInfo.frame = CGRectMake(10, 10, self.view.frame.size.width - 20, 40)
        changeInfo.backgroundColor = UIColor.whiteColor()
        changeInfo.layer.borderColor = UIColor.lightGrayColor().CGColor
        changeInfo.layer.borderWidth = 0.5
        changeInfo.layer.cornerRadius = 8
        self.view.addSubview(changeInfo)
        
        changeInfo.text = infoText
    }
    
    func rightBarButtonClicked(){
        let str = changeInfo.text
        if changeType == 0 {
            helper.upLoadShopInfoWithId(self.strId, shopname: str, success: { [unowned self] (dic) in
                if self.myHandle != nil {
                    self.myHandle!(str: self.changeInfo.text!)
                }
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("修改成功")
                    self.navigationController?.popViewControllerAnimated(true)
                })
                }, faild: { [unowned self] (str, err) in
                    st_dispatch_async_main({
                        SVProgressHUD.showErrorWithStatus("修改失败")
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                })
            
        }else if changeType == 4{
            helper.upLoadShopInfoWithId(self.strId, address: str, success: { [unowned self] (dic) in
                if self.myHandle != nil {
                    self.myHandle!(str: self.changeInfo.text!)
                }
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("修改成功")
                    self.navigationController?.popViewControllerAnimated(true)
                })
                }, faild: { [unowned self] (str, err) in
                    st_dispatch_async_main({
                        SVProgressHUD.showErrorWithStatus("修改失败")
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                })

        }
        
    }
    
    func setInfoHandle(handle:SingleInfoHandle){
        myHandle = handle
    }

}
