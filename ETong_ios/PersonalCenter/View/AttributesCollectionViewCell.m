//
//  AttributesCollectionViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AttributesCollectionViewCell.h"

@implementation AttributesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.btn = [[UIButton alloc] init];
        
//        self.btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.btn];
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.btn.frame = self.contentView.frame;
    
}

@end
