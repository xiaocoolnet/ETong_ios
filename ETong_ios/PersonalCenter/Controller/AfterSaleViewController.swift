//
//  AfterSaleViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class AfterSaleViewController: UIViewController {
    
     let aview = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        AddHeaderView()
    }

    func AddHeaderView(){
    
        aview.backgroundColor = UIColor(red: 253/255, green: 74/255, blue: 75/255, alpha: 1)
        aview.frame = CGRectMake(10, 10, self.view.frame.size.width - 20, 160)
        self.view.addSubview(aview)
        
        let header = UILabel ()
        header.frame = CGRectMake(0, 20, self.aview.frame.size.width, 30)
        header.text = "商家待处理订单"
        header.textAlignment = .Center
        header.font = UIFont.systemFontOfSize(18)
        header.textColor = UIColor.whiteColor()
        aview.addSubview(header)
        
        addButton()
    }
    
    func addButton(){
        let array = ["申请退款","已退货","72小时逾期"]
        for i in 0...2 {
            let button = UIButton()
            button.frame = CGRectMake((self.aview.frame.size.width/3) * CGFloat(i), 60, self.aview.frame.size.width/3.0, 100)
//            button.backgroundColor = UIColor.whiteColor()
            aview.addSubview(button)
            let lable = UILabel()
            lable.frame = CGRectMake(0, 0, button.frame.size.width, 40)
            lable.text = array[i]
            lable.textAlignment = .Center
            lable.font = UIFont.systemFontOfSize(15)
            lable.textColor = UIColor.whiteColor()
            button.addSubview(lable)
            
            let num = UILabel()
            num.frame = CGRectMake(0, 50, button.frame.size.width, 40)
            num.text = "0单"
            num.textAlignment = .Center
            num.font = UIFont.systemFontOfSize(15)
            num.textColor = UIColor.whiteColor()
            button.addSubview(num)
            
        }
    }
    
    
}
