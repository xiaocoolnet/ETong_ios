//
//  NewsTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"CCTV";
        self.nameLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.nameLab];
        
        self.contentLab = [[UILabel alloc] init];
        self.contentLab.text = @"这样的蝴蝶的户你准备";
        self.contentLab.textColor = [UIColor lightGrayColor];
        self.contentLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLab];
        
        self.aview = [[UIView alloc] init];
        self.aview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.aview];
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        self.imgView.layer.cornerRadius = 30;
        self.imgView.clipsToBounds = YES;
        [self.contentView addSubview:self.imgView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(20, 10, 60, 60);
    self.nameLab.frame = CGRectMake(90, 10, self.contentView.frame.size.width - 90, 30);
    self.contentLab.frame = CGRectMake(90, 40, self.contentView.frame.size.width - 90, 30);
    self.aview.frame = CGRectMake(0, 79, self.contentView.frame.size.width, 1);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
