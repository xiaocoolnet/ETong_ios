//
//  SendGoodsViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SendGoodsViewController: UIViewController, UITextFieldDelegate {

    let textField = UITextField()
    let btn = UIButton()
    var dataArray = OrderListModel()
    var helper:ETShopHelper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "订单管理"
        AddHeaderView()
        addMidView()
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.redColor()
        btn.frame = CGRectMake(0, self.view.frame.size.height - 64 - 50, self.view.frame.size.width, 50)
        btn.setTitle("发货", forState: .Normal)
        btn.addTarget(self, action: #selector(self.sendGoodBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
    }

    func AddHeaderView(){
        let aview = UIView()
        aview.frame = CGRectMake(0, 0, self.view.frame.size.width, 120)
        aview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(aview)
        
        let imgView = UIImageView()
        imgView.frame = CGRectMake(10, 10, 100, 100)
        aview.addSubview(imgView)
        let strArray = dataArray.picture.componentsSeparatedByString(",")
        let str = kIMAGE_URL_HEAD + strArray.first!
        let photourl = NSURL(string: str)
        imgView.sd_setImageWithURL(photourl, placeholderImage: UIImage(named: "ic_xihuan"))
        
        let orderLab = UILabel()
        orderLab.frame = CGRectMake(120, 15, self.view.frame.size.width - 120, 30)
        orderLab.font = UIFont.systemFontOfSize(16)
        orderLab.text = "订单编号: " + dataArray.order_num
        aview.addSubview(orderLab)
        
        let payTimeLab = UILabel()
        payTimeLab.frame = CGRectMake(120, 45, self.view.frame.size.width - 120, 30)
        payTimeLab.font = UIFont.systemFontOfSize(16)
        payTimeLab.text = "付款时间: 2016.8.26"
        aview.addSubview(payTimeLab)
        
        let successLab = UILabel()
        successLab.frame = CGRectMake(120, 75, self.view.frame.size.width - 120, 30)
        successLab.font = UIFont.systemFontOfSize(16)
        successLab.text = "成交时间: 1970 01-01 08:00:00"
        aview.addSubview(successLab)
    }
    
    func addMidView(){
        btn.frame = CGRectMake(0, 130, self.view.frame.size.width, 49)
        btn.setTitle("请选择快递方式", forState: .Normal)
        btn.contentHorizontalAlignment = .Left;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        btn.addTarget(self, action: #selector(self.dropDoenMenu), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let lab = UILabel()
        lab.frame = CGRectMake(0, 180, self.view.frame.size.width, 49)
        lab.text = " 快递单号"
        lab.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(lab)
        lab.backgroundColor = UIColor.whiteColor()
        
        textField.frame = CGRectMake(0, 230, self.view.frame.size.width, 49)
        textField.placeholder = "请输入快递单号"
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.view.addSubview(textField)
        textField.backgroundColor = UIColor.whiteColor()
    }
    
    func dropDoenMenu(btn:UIButton){
        let menuView = YLDropDownMenu(frame: CGRectMake(20, 182, self.view.frame.size.width - 40, 240))
        menuView.dataSource = ["顺风快递","圆通快递","申通快递","韵达快递","百世快递","邮政快递","EMS"]
        menuView.type = "1"
        self.view.addSubview(menuView)
        menuView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        menuView.finishBlock = { (AnyObject) -> () in
            print(AnyObject);
            btn.setTitle(AnyObject, forState: .Normal)
            menuView.removeFromSuperview()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func sendGoodBtn(){
        helper.sendGoodsWithUserid(dataArray.id, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("发货成功")
                self.navigationController?.popViewControllerAnimated(true)
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("发货失败")
            })
        }
    }
    
    //点击空白处回收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
