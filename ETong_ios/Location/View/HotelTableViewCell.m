
//
//  HotelTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "HotelTableViewCell.h"

@implementation HotelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"美女";
        [self.contentView addSubview:self.nameLab];
        
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        [self.contentView addSubview:self.imgView];
        
        self.img = [[UIImageView alloc] init];
        [self.contentView addSubview:self.img];
        
        self.priceLab = [[UILabel alloc] init];
        self.priceLab.text = @"¥50起";
        self.priceLab.textAlignment = NSTextAlignmentLeft;
        self.priceLab.font = [UIFont systemFontOfSize:16];
        self.priceLab.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLab];
        
        self.distanceLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.distanceLab];
        self.distanceLab.textColor = [UIColor lightGrayColor];
        self.distanceLab.font = [UIFont systemFontOfSize:14];
        self.distanceLab.textAlignment = NSTextAlignmentRight;
        self.distanceLab.text = @"小于500m";
        
        self.aview = [[UIView alloc] init];
        self.aview.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [self.contentView addSubview:self.aview];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 10, 100, 100);
    self.nameLab.frame = CGRectMake(120, 10, 120, 30);
    self.distanceLab.frame = CGRectMake(self.contentView.frame.size.width - 130, 10, 120, 20);
    self.priceLab.frame = CGRectMake(120, 80, 200, 30);
    self.aview.frame = CGRectMake(0, 120, self.contentView.frame.size.width, 10);
    self.img.frame = CGRectMake(120, 50, 130, 20);
}


@end
