//
//  FoodTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLab];
        
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        [self.contentView addSubview:self.imgView];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLab];
        
        self.priceLab = [[UILabel alloc] init];
        self.priceLab.text = @"500¥";
        self.priceLab.textAlignment = NSTextAlignmentLeft;
        self.priceLab.font = [UIFont systemFontOfSize:14];
        self.priceLab.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLab];
        
        self.addressLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.addressLab];
        self.addressLab.textColor = [UIColor lightGrayColor];
        self.addressLab.font = [UIFont systemFontOfSize:16];
        self.addressLab.textAlignment = NSTextAlignmentRight;
        
        self.opriceLab = [[UILabel alloc] init];
        self.opriceLab.textColor = [UIColor lightGrayColor];
        self.opriceLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.opriceLab];
        
        self.yishouLab = [[UILabel alloc] init];
        _yishouLab.textColor = [UIColor lightGrayColor];
        _yishouLab.text = @"已售: 123";
        _yishouLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.yishouLab];
        self.yishouLab.textAlignment = NSTextAlignmentRight;
        
        self.line = [[UILabel alloc] init];
        self.line.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [self.contentView addSubview:self.line];
        
        self.aview = [[UIView alloc] init];
        self.aview.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [self.contentView addSubview:self.aview];
        
        self.starImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.starImg];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, 20);
    self.addressLab.frame = CGRectMake(self.contentView.frame.size.width - 140, 40, 130, 20);
    self.line.frame = CGRectMake(10, 70, self.contentView.frame.size.width - 20, 0.5);
    self.imgView.frame = CGRectMake(10, 80, 100, 75);
    self.titleLab.frame = CGRectMake(120, 80, self.contentView.frame.size.width - 130, 40);
//    self.priceLab.frame = CGRectMake(120, 130, 60, 20);
    self.starImg.frame = CGRectMake(10, 40, 130, 20);
    self.yishouLab.frame = CGRectMake(self.contentView.frame.size.width - 160, 135, 150, 20);
    self.aview.frame = CGRectMake(0, 165, self.contentView.frame.size.width, 10);
}



@end
