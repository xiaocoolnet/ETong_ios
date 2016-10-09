//
//  RecreationCollectionViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "RecreationCollectionViewCell.h"

@implementation RecreationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"美女";
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLab];
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.nameLab.frame = self.contentView.frame;
    
}

@end
