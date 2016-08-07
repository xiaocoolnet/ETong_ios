//
//  ETUploadGoodsController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETUploadGoodsController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var goodsTitle:UITextField!//标题
    @IBOutlet weak var goodsBrand:UITextField!//品牌
    @IBOutlet weak var goodsNumber:UITextField!//货号
    @IBOutlet weak var goodsSpec:UITextField!//规格
    @IBOutlet weak var price:UITextField!//现价
    @IBOutlet weak var originalPrice:UITextField!//原价
    @IBOutlet weak var freight:UITextField!//运费
    @IBOutlet weak var goodsStock:UITextField!//库存
    @IBOutlet weak var goodsDetail:UITextField!//宝贝详情
    @IBOutlet weak var place:UITextField!//发货地
    @IBOutlet weak var goodsClass:UIButton!//商品分类
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "上传宝贝"
        
        goodsClass.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).CGColor
        goodsClass.layer.borderWidth = 1
        goodsClass.layer.cornerRadius = 4
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        self.view.endEditing(true)
    }
    //商品轮播图
    @IBAction func goodsLoopImage(sender: AnyObject){
        
    }
    //商品分类
    @IBAction func goodsClass(sender: AnyObject){
        
    }
    //上传
    @IBAction func uploadAction(sender: AnyObject){
        
    }
}