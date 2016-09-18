//
//  ETGMSellCell.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETGMSellCell: UITableViewCell {
    
    @IBOutlet weak var goodsImage:UIImageView!
    @IBOutlet weak var editGoods:UIButton!
    @IBOutlet weak var offSaleBtn:UIButton!
    @IBOutlet weak var shareBtn:UIButton!
    @IBOutlet weak var deleteBtn:UIButton!
    @IBOutlet weak var goodsName:UILabel!
    @IBOutlet weak var hasSaleNum:UILabel!
    @IBOutlet weak var goodsPrice:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func showForModel(model:ETGoodsDataModel){
        goodsImage.sd_setImageWithURL(NSURL(string:kIMAGE_URL_HEAD + model.picture.componentsSeparatedByString(",").first!) , placeholderImage: UIImage(named: "ic_xihuan"))
        goodsName.text = model.goodsname
        hasSaleNum.text = "已售:"+"库存:"
        goodsPrice.text = model.price
    }
    
    func setViewsTag(viewTag:Int){
        editGoods.tag = viewTag
        offSaleBtn.tag = viewTag
        shareBtn.tag = viewTag
        deleteBtn.tag = viewTag
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}