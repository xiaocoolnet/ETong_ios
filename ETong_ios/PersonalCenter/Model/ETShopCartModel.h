//
//  ETShopCartModel.h
//  ETong_ios
//
//  Created by xiaocool on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETShopCartModel : NSObject

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *shopid;
@property (copy, nonatomic) NSString *shopname;
@property (copy, nonatomic) NSArray  *goodslist;

@end
