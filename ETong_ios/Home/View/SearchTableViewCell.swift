//
//  SearchTableViewCell.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var goosname: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var opriceLab: UILabel!
    @IBOutlet weak var yishouLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
