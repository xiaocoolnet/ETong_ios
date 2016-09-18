//
//  ETGoodsJudgeCell.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETGoodsJudgeCell: UITableViewCell {

    @IBOutlet weak var avatarBtn:UIButton!
    @IBOutlet weak var judgeBtn:UIButton!
    @IBOutlet weak var likeBtn:UIButton!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var infoLabel:UILabel!
    @IBOutlet weak var descript:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
