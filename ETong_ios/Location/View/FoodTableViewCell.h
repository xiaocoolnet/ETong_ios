//
//  FoodTableViewCell.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *opriceLab;
@property (nonatomic, strong) UILabel *yishouLab;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *line;
@property (nonatomic, strong) UIView *aview;

@end
