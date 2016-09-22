//
//  QualityLifeCollectionViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "QualityLifeCollectionViewCell.h"

@implementation QualityLifeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.aview = [[UIView alloc] init];
        [self.contentView addSubview:_aview];
        self.aview.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"ic_xihuan"];
        [self.aview addSubview:self.imgView];
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"美女";
        [self.aview addSubview:self.nameLab];
        
        self.priceLab = [[UILabel alloc] init];
        self.priceLab.text = @"¥500";
        [self.priceLab sizeToFit];
        self.priceLab.font = [UIFont systemFontOfSize:16];
        self.priceLab.textColor = [UIColor redColor];
        
        [self.aview addSubview:self.priceLab];
        
        self.costLab = [[UILabel alloc] init];
        self.costLab.text = @"¥10";
        self.costLab.textColor = [UIColor lightGrayColor];
//        [self.costLab sizeToFit];
        self.costLab.font = [UIFont systemFontOfSize:11];
        [self.aview addSubview:self.costLab];
        
        self.line = [[UILabel alloc] init];
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self.costLab addSubview:self.line];
        
        self.peopleLab = [[UILabel alloc] init];
        self.peopleLab.font = [UIFont systemFontOfSize:12];
        self.peopleLab.text = @"¥128人已付款";
        [self.aview addSubview:self.peopleLab];
        
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.aview.frame = self.contentView.bounds;
    self.imgView.frame = CGRectMake(0, 5, self.aview.frame.size.width, 140);
    self.nameLab.frame = CGRectMake(10, 160, self.aview.frame.size.width - 20, 20);
    self.priceLab.frame = CGRectMake(10, 195, 40, 20);
    self.costLab.frame = CGRectMake(60, 200, 40, 20);
    self.line.frame = CGRectMake(60, 210, 30, 0.5);
    self.peopleLab.frame = CGRectMake(95, 190, self.aview.frame.size.width - 95, 20);
}


@end
