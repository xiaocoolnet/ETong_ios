//
//  ETSpecialSaleCell.h
//  ETong_ios
//
//  Created by xiaocool on 16/9/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETSpecialSaleCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsname;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *opriceLab;
@property (weak, nonatomic) IBOutlet UILabel *buyNumLab;

@end
