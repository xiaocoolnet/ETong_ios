//
//  NewProductModel.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "NewProductModel.h"

@implementation NewProductModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        self.descriptio = value;
    }
    
}


@end


@implementation Shop_Name

@end


