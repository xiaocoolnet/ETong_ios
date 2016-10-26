//
//  ETEditInfoController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETEditInfoController: UIViewController {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var infoView: UITextField!
    var itemStr = ""
    var infoType:Int = 0
    var saveHandle:ETResponseBlock?
    var goodsModel:ETGoodsDataModel?
    var helper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改"+itemStr
        itemName.text = itemStr
        let itemBtn = UIButton(type: .Custom)
        itemBtn.frame = CGRectMake(0, 0, 60, 35)
        itemBtn.setTitle("保存", forState: .Normal)
        itemBtn.addTarget(self, action: #selector(savaInfo), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: itemBtn)
        // Do any additional setup after loading the view.
    }
    
    func showForTitle(title:String, handle:ETResponseBlock){
        itemStr = title
        saveHandle = handle
    }
    
    func savaInfo(){
        if saveHandle != nil {
            saveHandle!(["info":infoView.text!])
        }
        //名称
        if infoType == 2 {
            helper.updateGoodsNameWithGoodsId(goodsModel?.id, goodsName: infoView.text, success: { (dic) in
                print(dic)
                }, faild: { (string, error) in
                    
            })
        }
        //价格
        if infoType == 21 {
            helper.updateGoodsPriceWithGoodsId(goodsModel?.id, goodsprice: infoView.text, success: { (dic) in
                    print(dic)
                }, faild: { (str, error) in
                
            })
        }
        // 原价
        if infoType == 22 {
            helper.updateGoodsOPriceWithGoodsId(goodsModel?.id, OPrice: infoView.text, success: { (dic) in
                print(dic)
                }, faild: { (str, error) in
                    
            })
        }
        // 描述
        if infoType == 1 {
            helper.updateGoodsDescriptionWithGoodsid(goodsModel?.id, description: infoView.text, success: { (dic) in
                print(dic)
                }, faild: { (str, error) in
                    
            })
        }
        // 品牌
        helper.updateGoodsBrandWithGoodsid(goodsModel?.id, band: infoView.text, success: { (dic) in
            print(dic)
            }, faild: { (str, error) in
                
        })
        // 
        navigationController?.popViewControllerAnimated(true)
    }

}
