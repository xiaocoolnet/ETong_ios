//
//  AllOrderTableViewCell.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class AllOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameImgView: UIImageView!
    
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var stateLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var classifyLab: UILabel!
    
    @IBOutlet weak var sizeLab: UILabel!
    @IBOutlet weak var sizeNumLab: UILabel!
    @IBOutlet weak var moneyLab: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
