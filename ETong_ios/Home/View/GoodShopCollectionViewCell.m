//
//  GoodShopCollectionViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "GoodShopCollectionViewCell.h"

@implementation GoodShopCollectionViewCell

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
        self.nameLab.numberOfLines = 0;
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        [self.aview addSubview:self.nameLab];
        
        self.priceLab = [[UILabel alloc] init];
        self.priceLab.text = @"500¥";
        self.priceLab.numberOfLines = 0;
        self.priceLab.textAlignment = NSTextAlignmentLeft;
        self.priceLab.font = [UIFont systemFontOfSize:16];
        self.priceLab.textColor = [UIColor redColor];
        
        [self.aview addSubview:self.priceLab];
        
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.aview.frame = self.contentView.bounds;
    self.imgView.frame = CGRectMake(0, 5, self.aview.frame.size.width, 140);
    self.nameLab.frame = CGRectMake(5, 150, self.aview.frame.size.width - 10, 30);
    self.priceLab.frame = CGRectMake(5, 190, self.aview.frame.size.width - 10, 30);
   
}


@end
