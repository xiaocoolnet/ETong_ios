//
//  AllEBuyingTableViewCell.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllEBuyingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsname;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *opriceLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end