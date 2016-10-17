//
//  TableViewCell.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETAllOrderCell: UITableViewCell {
    
    @IBOutlet weak var userBtn:UIButton!
    @IBOutlet weak var bottomBtn:UIButton!
    @IBOutlet weak var goodsName:UILabel!
    @IBOutlet weak var goodsDescrpt:UILabel!
    @IBOutlet weak var goodsNumber:UILabel!
    @IBOutlet weak var goodsPrice:UILabel!
    @IBOutlet weak var stateLab: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomBtn.layer.cornerRadius = 4
        bottomBtn.layer.borderColor = UIColor.redColor().CGColor
        bottomBtn.layer.borderWidth = 0.5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}