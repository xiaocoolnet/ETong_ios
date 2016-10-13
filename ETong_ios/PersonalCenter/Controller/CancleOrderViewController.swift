//
//  CancleOrderViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class CancleOrderViewController: UIViewController, UITextViewDelegate {

    let textView = UITextView()
    let placeholder = UITextView()
    let sureBtn = UIButton()
    var strid = String()
    var helper:ETShopHelper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "取消订单"
        addTextView()
        addSureBtn()
    }

    func addTextView(){
        textView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        textView.backgroundColor = UIColor.clearColor()
        textView.scrollEnabled = true
        textView.editable = true
        textView.delegate = self;
        textView.textColor = UIColor.blackColor()
        textView.font = UIFont.systemFontOfSize(18)
        textView.returnKeyType = .Done
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        placeholder.frame = CGRectMake(0, 0, self.view.frame.size.width, 200)
        placeholder.backgroundColor = UIColor.whiteColor()
        placeholder.scrollEnabled = true
        placeholder.editable = true
        placeholder.delegate = self;
        placeholder.textColor = UIColor.lightGrayColor()
        placeholder.font = UIFont.systemFontOfSize(18)
        self.view.addSubview(placeholder)
        placeholder.returnKeyType = .Done
        placeholder.text = "请输入取消订单原因"
        self.view.addSubview(textView)
    }
    
    func addSureBtn(){
        sureBtn.frame = CGRectMake(self.view.frame.size.width - 120, 240, 100, 40)
        sureBtn.backgroundColor = UIColor.redColor()
        sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureBtn.setTitle("取消订单", forState: .Normal)
        sureBtn.titleLabel?.font = UIFont.systemFontOfSize(19)
        self.view.addSubview(sureBtn)
        sureBtn.addTarget(self, action: #selector(self.clickSureBtn), forControlEvents: .TouchUpInside)
    }
    
    func clickSureBtn(){
        print(strid)
        print(textView.text)
        helper .cancleOrderWithid(strid, reason: textView.text, success: {[unowned self] (dic) in
            st_dispatch_async_main({
            SVProgressHUD.showSuccessWithStatus("取消订单成功")
            self.navigationController?.popViewControllerAnimated(true)
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("取消订单失败")
            })
        }
    }
    
    // 占位字符
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        if text != "" {
            placeholder.hidden = true
        }
        if text == "" && range.location == 0 && range.length == 1 {
            placeholder.hidden = false
        }
        return true
    }
    


}
