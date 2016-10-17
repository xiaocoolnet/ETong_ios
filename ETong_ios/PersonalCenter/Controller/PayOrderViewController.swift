//
//  PayOrderViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class PayOrderViewController: UIViewController {

    var button : UIButton?
    let btnArr = NSMutableArray()
    var dataSource = OrderListModel()
    var helper:ETShopHelper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "支付订单"
        addHeaderView()
        addPaybtn()
        let payBtn = UIButton()
        payBtn.frame = CGRectMake(5, 350, self.view.frame.size.width - 10, 40)
        payBtn.setTitle("立即支付￥" + dataSource.money, forState: .Normal)
        payBtn.backgroundColor = UIColor.redColor()
        payBtn.titleLabel?.font = UIFont.systemFontOfSize(19)
        payBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        payBtn.layer.cornerRadius = 7;
        self.view.addSubview(payBtn)
        payBtn.addTarget(self, action: #selector(self.clcikPaySureBtn), forControlEvents: .TouchUpInside)
    }
    
    func clcikPaySureBtn(){
        helper.payOrderWithid(dataSource.id, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("支付订单成功")
                self.navigationController?.popViewControllerAnimated(true)
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("支付订单失败")
            })
        }
    }

    func addHeaderView(){
        let aview = UIView()
        aview.frame = CGRectMake(0, 0, self.view.frame.size.width, 120)
        aview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(aview)
        
        let img = UIImageView()
        img.frame = CGRectMake(self.view.frame.size.width/2 - 50, 40, 40, 40)
        img.image = UIImage(named: "ic_dianpu")
        aview.addSubview(img)
        
        let pirceLab = UILabel()
        pirceLab.frame = CGRectMake(self.view.frame.size.width/2, 40, self.view.frame.size.width/2, 20)
        pirceLab.textColor = UIColor.redColor()
        pirceLab.font = UIFont.systemFontOfSize(14)
        pirceLab.text = "￥" + dataSource.money
        aview.addSubview(pirceLab)
        
        let shopname = UILabel()
        shopname.frame = CGRectMake(self.view.frame.size.width/2, 60, self.view.frame.size.width/2, 20)
        shopname.textColor = UIColor.lightGrayColor()
        shopname.font = UIFont.systemFontOfSize(13)
        shopname.text = "e小妞原创店铺"
        aview.addSubview(shopname)
    }
    
    func addPaybtn(){
        let paytype = ["银行卡支付","微信支付","支付宝支付"]
        let content = ["支付储蓄卡银行，无需开通网银","推荐安装微信5.0及以上用户使用","推荐有支付宝的用户使用"]
        let imgArr = ["ic_ka","ic_weixin-1","ic_zhifubao"]
        
        for i in 0...2 {
            let btn = UIButton()
            btn.frame = CGRectMake(0, 140 + (CGFloat(i) * 51), self.view.frame.size.width, 50)
            btn.backgroundColor = UIColor.whiteColor()
            btn.tag = 1000+i
            btn.addTarget(self, action: #selector(self.clickPayButton), forControlEvents: .TouchUpInside)
            self.view.addSubview(btn)
            let img = UIImageView()
            img.frame = CGRectMake(10, 15, 20, 20)
            img.image = UIImage(named: imgArr[i])
            btn.addSubview(img)
            
            let typeLab = UILabel()
            typeLab.frame = CGRectMake(50, 0, self.view.frame.size.width - 80, 30)
            typeLab.text = paytype[i]
            typeLab.font = UIFont.systemFontOfSize(15)
            btn.addSubview(typeLab)
            
            let contentLab = UILabel()
            contentLab.frame = CGRectMake(50, 30, self.view.frame.size.width - 80, 20)
            contentLab.text = content[i]
            contentLab.textColor = UIColor.lightGrayColor()
            contentLab.font = UIFont.systemFontOfSize(13)
            btn.addSubview(contentLab)
            
           self.button = UIButton()
            button?.frame = CGRectMake(self.view.frame.size.width - 25, 15, 15, 15)
            button?.setImage(UIImage(named: "xn_circle_normal"), forState: .Normal)
            button?.setImage(UIImage(named: "xn_circle_select"), forState: .Selected)
            button?.selected = false
            btn.addSubview(button!)
            btnArr.addObject(button!)
        }
    }
    
    func clickPayButton(sender:UIButton){
        if sender.tag == 1000 {
            (btnArr[0] as! UIButton).selected = true
            (btnArr[1] as! UIButton).selected = false
            (btnArr[2] as! UIButton).selected = false
        }
        if sender.tag == 1001 {
            (btnArr[1] as! UIButton).selected = true
            (btnArr[0] as! UIButton).selected = false
            (btnArr[2] as! UIButton).selected = false
        }
        if sender.tag == 1002 {
            (btnArr[2] as! UIButton).selected = true
            (btnArr[1] as! UIButton).selected = false
            (btnArr[0] as! UIButton).selected = false
        }
    }
    
    
}
