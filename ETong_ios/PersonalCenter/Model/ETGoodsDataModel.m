//
//  ETGoodsDataModel.m
//  ETong_ios
//
//  Created by xiaocool on 16/8/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETGoodsDataModel.h"

@implementation ETGoodsDataModel
@synthesize description = _description;
+ (instancetype) modelWithShowid:(NSString *)showid piclist:(NSString *)piclist goodsname:(NSString *)goodsname type:(NSString *)type oprice:(NSString *)oprice price:(NSString *)price description:(NSString *)description unit:(NSString *)unit address:(NSString *)address longitude:(NSString *)longitude latitude:(NSString *)latitude freight:(NSString *)freight band:(NSString *)band;{
    
    ETGoodsDataModel *model = [[self alloc]init];
    model.shopid = showid;
    model.piclist = piclist?:@"";
    model.goodsname = goodsname;
    model.type = type;
    model.price = price;
    model.oprice = oprice;
    model.description = description;
    model.unit = unit;
    model.address = address;
    model.longitude = longitude;
    model.latitude = latitude;
    model.freight = freight;
    model.brand = band;
    
    return model;
}
- (void)setDescription:(NSString *)description{
    _description = description;
}
@end