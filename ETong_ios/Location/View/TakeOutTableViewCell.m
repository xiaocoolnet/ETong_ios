//
//  TakeOutTableViewCell.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "TakeOutTableViewCell.h"

@implementation TakeOutTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.line = [[UILabel alloc] init];
        self.line.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(10, 60, self.contentView.frame.size.width - 20, 0.5);
}
@end
