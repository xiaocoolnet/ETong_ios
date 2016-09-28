//
//  EvaluateTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "EvaluateTableViewCell.h"

@implementation EvaluateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"CCTV";
        self.nameLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.nameLab];
        
        self.contentLab = [[UILabel alloc] init];
        self.contentLab.text = @"这样的蝴蝶的户你准备";
        self.contentLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLab];
        
        self.aview = [[UIView alloc] init];
        self.aview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.aview];
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        [self.contentView addSubview:self.imgView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 10, 80, 80);
    self.nameLab.frame = CGRectMake(100, 15, Screen_frame.size.width - 110, 20);
    self.contentLab.frame = CGRectMake(100, 45, Screen_frame.size.width - 110, 55);
    self.aview.frame = CGRectMake(0, 109, Screen_frame.size.width, 1);
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
