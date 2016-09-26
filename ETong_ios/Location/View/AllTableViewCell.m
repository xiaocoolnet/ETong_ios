//
//  AllTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AllTableViewCell.h"

@implementation AllTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLab];
        
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        [self.contentView addSubview:self.imgView];
        
        self.addressLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.addressLab];
        self.addressLab.textColor = [UIColor lightGrayColor];
        self.addressLab.font = [UIFont systemFontOfSize:15];
        
        self.line = [[UILabel alloc] init];
        self.line.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(100, 20, self.contentView.frame.size.width - 110, 20);
    self.addressLab.frame = CGRectMake(100, 50, self.contentView.frame.size.width - 110, 20);
    self.line.frame = CGRectMake(0, 119.5, self.contentView.frame.size.width, 0.5);
    self.imgView.frame = CGRectMake(10, 20, 80, 80);
}


@end
