//
//  NowDayTableViewCell.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NowDayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *opriceLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *levelImg;


@end
