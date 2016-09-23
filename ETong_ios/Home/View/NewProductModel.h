//
//  NewProductModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Shop_Name;
@interface NewProductModel : NSObject


@property (nonatomic, strong) Shop_Name *shop_name;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *showid;

@property (nonatomic, copy) NSString *sall;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *isprice;

@property (nonatomic, copy) NSString *brand;

@property (nonatomic, copy) NSString *ise;

@property (nonatomic, copy) NSString *artno;

@property (nonatomic, copy) NSString *shopid;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *oprice;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *adtitle;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *freight;

@property (nonatomic, copy) NSString *racking;

@property (nonatomic, copy) NSString *pays;

@property (nonatomic, copy) NSString *recommend;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *hottype;

@property (nonatomic, copy) NSString *isnew;

@property (nonatomic, copy) NSString *islike;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) NSInteger sales;

@property (nonatomic, assign) NSInteger paynum;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *descriptio;


@end
@interface Shop_Name : NSObject

@property (nonatomic, copy) NSString *shopname;

@end

