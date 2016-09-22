//
//  FreeTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "FreeTableViewCell.h"

@implementation FreeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"CCTV";
        [self.contentView addSubview:self.nameLab];
        
        self.contentLab = [[UILabel alloc] init];
        self.contentLab.textColor = [UIColor lightGrayColor];
        self.contentLab.text = @"这样的蝴蝶的户数的为你准备";
        [self.contentView addSubview:self.contentLab];
        
        self.costLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.costLab];
        self.costLab.font = [UIFont systemFontOfSize:13];
        self.costLab.text = @"¥890";
        self.costLab.textColor = [UIColor lightGrayColor];
        
        self.priceLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.priceLab];
        self.priceLab.text = @"¥500";
        self.priceLab.textColor = [UIColor redColor];
        
        self.aview = [[UIView alloc] init];
        self.aview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.aview];
        
        self.btn = [[UIButton alloc] init];
        [self.contentView addSubview:self.btn];
//        [self.btn setTitle:@"马上购" forState:];
        self.btn.backgroundColor = [UIColor redColor];
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        [self.contentView addSubview:self.imgView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(0, 0, 120, 110);
    self.nameLab.frame = CGRectMake(130, 10, Screen_frame.size.width - 140, 20);
    self.contentLab.frame = CGRectMake(130, 40, Screen_frame.size.width - 140, 20);
    self.costLab.frame = CGRectMake(130, 65, 100, 20);
    self.priceLab.frame = CGRectMake(130, 90, 100, 20);
    self.btn.frame = CGRectMake(Screen_frame.size.width - 110, 80, 100, 30);
    self.aview.frame = CGRectMake(0, 110, Screen_frame.size.width, 10);
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
