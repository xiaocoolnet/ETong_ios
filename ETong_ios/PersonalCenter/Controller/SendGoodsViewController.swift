//
//  SendGoodsViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SendGoodsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "订单管理"
        AddHeaderView()
        addMidView()
    }

    func AddHeaderView(){
        let aview = UIView()
        aview.frame = CGRectMake(0, 0, self.view.frame.size.width, 120)
        aview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(aview)
        
        let imgView = UIImageView()
        imgView.frame = CGRectMake(10, 10, 100, 100)
        aview.addSubview(imgView)
        
        let orderLab = UILabel()
        orderLab.frame = CGRectMake(120, 15, self.view.frame.size.width - 120, 30)
        orderLab.font = UIFont.systemFontOfSize(16)
        orderLab.text = "订单编号: "
        aview.addSubview(orderLab)
        
        let payTimeLab = UILabel()
        payTimeLab.frame = CGRectMake(120, 45, self.view.frame.size.width - 120, 30)
        payTimeLab.font = UIFont.systemFontOfSize(16)
        payTimeLab.text = "付款时间: 2016.8.26"
        aview.addSubview(payTimeLab)
        
        let successLab = UILabel()
        successLab.frame = CGRectMake(120, 75, self.view.frame.size.width - 120, 30)
        successLab.font = UIFont.systemFontOfSize(16)
        successLab.text = "成交时间: 1970 01-01 08：00：00"
        aview.addSubview(successLab)
    }
    
    func addMidView(){
        let btn = UIButton()
        btn.frame = CGRectMake(0, 130, self.view.frame.size.width, 49)
        btn.setTitle("请选择快递方式", forState: .Normal)
        btn.contentHorizontalAlignment = .Left;
        btn.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
        self.view.addSubview(btn)
        
        
    }

}
