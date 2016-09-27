//
//  ETGoodsDataModel.h
//  ETong_ios
//
//  Created by xiaocool on 16/8/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSCartModel;

@interface ETGoodsDataModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *showid;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *brand;

@property (nonatomic, copy) NSString *stock;

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

@property (nonatomic, copy) NSString *recommend;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *address;
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *piclist;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *gid;

@property (nonatomic, copy) NSDictionary *property;

-(JSCartModel *)converToJSCartModel;

+ (instancetype) modelWithShowid:(NSString *)showid piclist:(NSString *)piclist goodsname:(NSString *)goodsname type:(NSString *)type oprice:(NSString *)oprice price:(NSString *)price description:(NSString *)description unit:(NSString *)unit address:(NSString *)address longitude:(NSString *)longitude latitude:(NSString *)latitude freight:(NSString *)freight band:(NSString *)band;

@end
