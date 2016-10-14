//
//  OrderDetailsTableViewCell.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var shopname: UILabel!
    @IBOutlet weak var statesLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var goodname: UILabel!
    @IBOutlet weak var typeLab: UILabel!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
