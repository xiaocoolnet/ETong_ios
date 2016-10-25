//
//  DaiUserTableViewCell.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class DaiUserTableViewCell: UITableViewCell {

    @IBOutlet weak var goodname: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
