//
//  EvaluateOrderViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class EvaluateOrderViewController: UIViewController, UITextViewDelegate {
    
    let textView = UITextView()
    let placeholder = UITextView()
    let sureBtn = UIButton()
    var strid = String()
    var helper:ETShopHelper = ETShopHelper()
    var dataArray = NSMutableArray()
    var img = String()
    var goodname = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "立即评价"
        addGoodsMessage()
        addTextView()
        addEvaluateBtn()
        addSureBtn()
    }
    
    func addGoodsMessage(){
        let aview = UIView()
        aview.backgroundColor = UIColor.whiteColor()
        aview.frame = CGRectMake(0, 0, self.view.frame.size.width, 100)
        self.view.addSubview(aview)
        
        let imgView = UIImageView()
        imgView.frame = CGRectMake(10, 10, 80, 80);
        aview.addSubview(imgView)
        let photourl = NSURL(string: img)
        imgView.sd_setImageWithURL(photourl, placeholderImage: UIImage(named: "ic_xihuan"))
        
        let goodsname = UILabel()
        goodsname.frame = CGRectMake(100, 10, self.view.frame.size.width - 110, 80)
        aview.addSubview(goodsname)
        goodsname.text = goodname
        
        
    }
// 添加textField
    func addTextView(){
        
        let backView = UIView()
        backView.backgroundColor = UIColor.whiteColor()
        backView.frame = CGRectMake(0, 100, self.view.frame.size.width, 150)
        self.view.addSubview(backView)
        
        textView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150)
        textView.backgroundColor = UIColor.clearColor()
        textView.scrollEnabled = true
        textView.editable = true
        textView.delegate = self;
        textView.textColor = UIColor.blackColor()
        textView.font = UIFont.systemFontOfSize(15)
        textView.returnKeyType = .Done
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        placeholder.frame = CGRectMake(0, 0, self.view.frame.size.width, 150)
        placeholder.backgroundColor = UIColor.whiteColor()
        placeholder.scrollEnabled = true
        placeholder.editable = true
        placeholder.delegate = self;
        placeholder.textColor = UIColor.lightGrayColor()
        placeholder.font = UIFont.systemFontOfSize(15)
        backView.addSubview(placeholder)
        placeholder.returnKeyType = .Done
        placeholder.text = "亲！写下对宝贝的评价吧"
        backView.addSubview(textView)
    }
    
    func addSureBtn(){
        sureBtn.frame = CGRectMake(0, self.view.frame.size.height - 50 - 64, self.view.frame.size.width, 50)
        sureBtn.backgroundColor = UIColor.redColor()
        sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureBtn.setTitle("立即评价", forState: .Normal)
        sureBtn.titleLabel?.font = UIFont.systemFontOfSize(19)
        self.view.addSubview(sureBtn)
        sureBtn.addTarget(self, action: #selector(self.clickSureBtn), forControlEvents: .TouchUpInside)
    }
    
    func addEvaluateBtn(){
        let bview = UIView()
        bview.frame = CGRectMake(0, 260, self.view.frame.size.width, 40);
        bview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bview)
        
        let lable = UILabel()
        lable.frame = CGRectMake(10, 0, 80, 40)
        lable.text = "店铺评分"
        lable.font = UIFont.systemFontOfSize(16)
        bview.addSubview(lable)
        
        for i in 0...4 {
            let btn = UIButton()
            btn.frame = CGRectMake(95 + (30 * CGFloat(i)), 10, 20, 20)
            btn.setImage(UIImage(named: "ic_yellow_bian"), forState: .Normal)
            btn.setImage(UIImage(named: "ic_yellowstar_quan"), forState: .Selected)
            btn.selected = true;
            btn.tag = i+1
            bview.addSubview(btn)
            btn.addTarget(self, action:#selector(self.clcikEvaluateBtn), forControlEvents: .TouchUpInside)
            dataArray.addObject(btn)
            
        }
    }
    
    func clcikEvaluateBtn(sender:UIButton){
        textView.resignFirstResponder()
        placeholder.resignFirstResponder()
        self.view.endEditing(true)
        if sender.tag == 1 {
            (dataArray[1] as! UIButton).selected = false
            (dataArray[2] as! UIButton).selected = false
            (dataArray[3] as! UIButton).selected = false
            (dataArray[4] as! UIButton).selected = false
        }else if sender.tag == 2{
            (dataArray[1] as! UIButton).selected = true
            (dataArray[2] as! UIButton).selected = false
            (dataArray[3] as! UIButton).selected = false
            (dataArray[4] as! UIButton).selected = false
        }else if sender.tag == 3{
            (dataArray[1] as! UIButton).selected = true
            (dataArray[2] as! UIButton).selected = true
            (dataArray[3] as! UIButton).selected = false
            (dataArray[4] as! UIButton).selected = false
        }else if sender.tag == 4{
            (dataArray[1] as! UIButton).selected = true
            (dataArray[2] as! UIButton).selected = true
            (dataArray[3] as! UIButton).selected = true
            (dataArray[4] as! UIButton).selected = false
        }else{
            (dataArray[0] as! UIButton).selected = true
            (dataArray[1] as! UIButton).selected = true
            (dataArray[2] as! UIButton).selected = true
            (dataArray[3] as! UIButton).selected = true
            (dataArray[4] as! UIButton).selected = true
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
        placeholder.resignFirstResponder()
        self.view.endEditing(true)
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
    
    func clickSureBtn(){
        helper.evaluateOrderWithUserid(ETUserInfo.sharedETUserInfo().Id, orderid: strid, type: "5", content: textView.text, attitudescore: "5", finishscore: "5", effectscore: "5", success: {[unowned self] (dic) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("评价成功")
                self.navigationController?.popViewControllerAnimated(true)
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("评价失败")
            })
        }
    }

}
