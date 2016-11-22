//
//  ETMyShopController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/7/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETMyShopController: UIViewController {
    @IBOutlet weak var shopTitle:UILabel!
    @IBOutlet weak var shopImage:UIButton!
    @IBOutlet weak var avatarBack:UIView!
    var helper:ETShopHelper = ETShopHelper()
    var model:ETShopModel?
    
    override func viewWillAppear(animated: Bool) {
        getShopS()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.title = "我的店铺"
//        shopTitle.text = model?.shopname
//        ETUserInfo.sharedETUserInfo().shopid = model?.id
//        shopImage.sd_setImageWithURL(NSURL(string: kIMAGE_URL_HEAD + (model?.photo)!), forState: UIControlState.Normal, placeholderImage: UIImage(named: "ic_xihuan"))
        avatarBack.layer.borderColor = UIColor.whiteColor().CGColor
        avatarBack.layer.borderWidth = 1
    }
    //店铺管理
    @IBAction func shopManagerAction(sender: AnyObject) {
        let vc = ETShopManagerController(nibName: "ETShopManagerController", bundle: nil)
        vc.shopModel = model
        navigationController?.pushViewController(vc, animated: true)
    }
    //上传宝贝
    @IBAction func uploadGoods(sender: AnyObject) {
        let vc = ETUploadGoodsController(nibName: "ETUploadGoodsController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    //宝贝管理
    @IBAction func goodsManagerAction(sender: AnyObject) {
        let managerVC = ETGoodsManagerController(nibName: "ETGoodsManagerController", bundle: nil)
        managerVC.shopModel = model
        navigationController?.pushViewController(managerVC, animated: true)
    }
    //订单管理
    @IBAction func orderManager(sender: AnyObject) {
        let orderManager = ETOrderManagerController()
        navigationController?.pushViewController(orderManager, animated: true)
    }
    // 评价管理
    @IBAction func AppraiseManager(sender: AnyObject) {
        let vc = AppraiseViewController()
        vc.title = "评价管理"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    // 问题求助
    @IBAction func ClickHelperBtn(sender: AnyObject) {
        var phone = String()
        phone = "telprompt:\(String(model!.contactphone))"
        UIApplication.sharedApplication().openURL(NSURL.init(string: phone)!)
    }
    // 售后管理
    @IBAction func AfterSaleManager(sender: AnyObject) {
       let vc = AfterSaleViewController()
        vc.title = "售后管理"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getShopS(){
        self.helper.getMyShopInfoWithuserid(ETUserInfo.sharedETUserInfo().Id, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                self.model = (dic as NSDictionary).objectForKey("goods") as? ETShopModel
                
                self.shopTitle.text = self.model?.shopname
                ETUserInfo.sharedETUserInfo().shopid = self.model?.id
                self.shopImage.sd_setImageWithURL(NSURL(string: kIMAGE_URL_HEAD + (self.model?.photo)!), forState: UIControlState.Normal, placeholderImage: UIImage(named: "ic_xihuan"))
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("网络错误")
            })
        }
    }
}