//
//  ETShopManagerController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/7/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETShopManagerController: UIViewController {
    
    var shopModel:ETShopModel?
    
    @IBOutlet weak var shopImage:UIImageView!
    @IBOutlet weak var shopName:UITextField!
    @IBOutlet weak var backImage:UILabel!
    @IBOutlet weak var descrpt:UILabel!
    @IBOutlet weak var linkWay:UILabel!
    @IBOutlet weak var shopAddress:UILabel!
    @IBOutlet weak var sendAddress:UILabel!
    @IBOutlet weak var receive:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "店铺信息"
        // Do any additional setup after loading the view.
        if shopModel != nil {
            shopImage.sd_setImageWithURL(NSURL(string:kIMAGE_URL_HEAD+(shopModel?.photo)!), placeholderImage: UIImage(named: "ic_touxiang"))
            shopName.text = shopModel?.shopname
        }
    }
}
