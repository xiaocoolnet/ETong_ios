//
//  ETSingleInfoController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

typealias SingleInfoHandle = (str :String) -> Void

class ETSingleInfoController: UIViewController {
    
    @IBOutlet weak var changeInfo:UITextField!
    var infoText = ""
    var myHandle:SingleInfoHandle?
    var changeType = 0
    let helper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeInfo.text = infoText
        let rightButton = UIButton(type: .Custom)
        rightButton.frame = CGRectMake(0, 0, 50, 30)
        rightButton.setTitle("保存", forState: .Normal)
        rightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightButton.addTarget(self, action: #selector(rightBarButtonClicked), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    func rightBarButtonClicked(){
        let str = changeInfo.text
        if changeType == 0 {
            helper.updataUserNameWithUserid(ETUserInfo.sharedETUserInfo().Id, nicename:str , success: { [unowned self] (dic) in
                ETUserInfo.sharedETUserInfo().name = str
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
        }else if changeType == 1{
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        changeInfo.becomeFirstResponder()
    }
    
    func setInfoHandle(handle:SingleInfoHandle){
        myHandle = handle
    }
}
