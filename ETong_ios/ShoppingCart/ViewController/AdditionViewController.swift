//
//  AdditionViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class AdditionViewController: UIViewController, AddressPickerDelegate {
    
    let phoneNum  = UITextField()
    let nameTextField = UITextField()
    let selectBtn = UIButton()
    let addressText = UITextField()
    
    var pickerView : AddressView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.addView()
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 40, 20)
        btn.setTitle("确定", forState: .Normal)
        btn.addTarget(self, action: #selector(self.sure), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func sure(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    func addView(){
        let aview = UIView()
        aview.frame = CGRectMake(0, 0, self.view.frame.size.width, 101)
        aview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(aview)
        
        let phone = UILabel()
        phone.frame = CGRectMake(10, 0, 100, 50)
        phone.text = "手机号"
        aview.addSubview(phone)
        
        phoneNum.placeholder = "请输入手机号"
        phoneNum.frame = CGRectMake(120, 0, self.view.frame.size.width - 120, 50)
        aview.addSubview(phoneNum)
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        line.frame = CGRectMake(0, 50, self.view.frame.size.width, 1)
        aview.addSubview(line)
        
        
        let name = UILabel()
        name.frame = CGRectMake(10, 51, 100, 50);
        name.text = "姓名"
        aview.addSubview(name)
        
        nameTextField.frame = CGRectMake(120, 51, self.view.frame.size.width - 120, 50);
        nameTextField.placeholder = "请输入姓名"
        aview.addSubview(nameTextField)
        
        selectBtn.frame = CGRectMake(0, 120, self.view.frame.size.width, 40)
        selectBtn.backgroundColor = UIColor.whiteColor()
        selectBtn.setTitle("请选择地址", forState: .Normal)
        selectBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        selectBtn.addTarget(self, action: #selector(self.ClickselectBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(selectBtn)
        
        self.addressText.frame = CGRectMake(5, 170, self.view.frame.size.width - 10, 40);
        self.addressText.backgroundColor = UIColor.whiteColor()
        self.addressText.placeholder = "请输入详细地址"
        self.addressText.font = UIFont.systemFontOfSize(15);
        self.view.addSubview(addressText)
    }
    
    func ClickselectBtn(){
        self.pickerView = AddressView.init(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        pickerView!.delegate = self
        pickerView!.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(pickerView!)
    }
    
    func JSAddressCancleAction(senter: AnyObject!) {
        self.pickerView!.removeFromSuperview()
    }
    func JSAddressPickerRerurnBlockWithProvince(province: String!, city: String!, town: String!) {
        selectBtn.setTitle(province+city+town, forState: .Normal)
        self.pickerView!.removeFromSuperview()
    }

}
