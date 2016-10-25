//
//  SortCollectionViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SortCollectionViewCell.h"

@implementation SortCollectionViewCell

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
        self.nameLab.font = [UIFont systemFontOfSize:15];
        self.nameLab.textColor = [UIColor lightGrayColor];
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        [self.aview addSubview:self.nameLab];
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.aview.frame = self.contentView.bounds;
    self.imgView.frame = CGRectMake(0, 0, self.aview.frame.size.width, 80);
    self.nameLab.frame = CGRectMake(0, 80, self.aview.frame.size.width, 30);
    
}


@end
