//
//  ETShopHelper.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETShopHelper.h"
#import "ETGoodsDataModel.h"
#import "ETShopCartModel.h"

@implementation ETShopHelper

- (void)upDataCreatShopInfoWithUserid:(NSString *)userid city:(NSString *)city shopName:(NSString *)shopName legalperson:(NSString *)legalPerson phone:(NSString *)phone type:(NSString *)type businesslicense:(NSString *)businesslicense address:(NSString *)address idcard:(NSString *)idcard positive_pic:(NSString *)positive_pic opposite_pic:(NSString *)opposite_pic license_pic:(NSString *)license_pic success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    
    NSDictionary *para = @{@"a":@"CreateShop",@"userid":userid,@"city":city,@"shopName":shopName,@"legalperson":legalPerson,@"phone":phone,@"type":type,@"businesslicense":businesslicense,@"address":address,@"idcard":idcard,@"positive_pic":positive_pic,@"opposite_pic":opposite_pic,@"license_pic":license_pic};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)getMyShopInfoWithUserid:(NSString *)userid
                        success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;{
    
    NSDictionary *para = @{@"a":@"GetMyShop",@"userid":userid};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

- (void)updataUserAvatarWithUserid:(NSString *)userid avatar:(NSString *)avatar success:(ETResponseBlock) success
                        faild:(ETResponseErrorBlock) faild;{
    NSDictionary *para = @{@"a":@"UpdateUserAvatar",@"userid":userid,@"avatar":avatar};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
- (void)updataUserNameWithUserid:(NSString *)userid Nicename:(NSString *)nicename success:(ETResponseBlock) success
                           faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateUserName",@"userid":userid,@"nicename":nicename};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
- (void)updataUserSexWithUserid:(NSString *)userid sex:(NSNumber *)sex success:(ETResponseBlock) success
                          faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateUserSex",@"userid":userid,@"sex":sex};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

- (void)updataUserPhone:(NSString *)phone userid:(NSString *)userid code:(NSString *)code success:(ETResponseBlock) success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateUserPhone",@"userid":userid,@"phone":phone,@"code":code};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

- (void)updataUserAddress:(NSString *)address userid:(NSString *)userid success:(ETResponseBlock) success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateUserAddress",@"userid":userid,@"address":address};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
- (void)uploadGoodsWithGoodsModel:(ETGoodsDataModel *)model success:(ETResponseBlock) success faild:(ETResponseErrorBlock) faild;{
    
    NSDictionary *para = @{@"a":@"PublishGoods",@"userid":[ETUserInfo sharedETUserInfo].id,@"shopid":model.shopid,@"piclist":model.piclist,@"goodsname":model.goodsname,@"type":model.type,@"oprice":model.oprice,@"price":model.price,@"description":model.description,@"unit":model.unit,@"address":model.address,@"longitude":model.longitude,@"latitude":model.latitude,@"freight":model.freight,@"band":model.brand};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

- (void)getShopGoodsListWithShopid:(NSString *)shopid userid:(NSString *)userid xiajia:(NSString *)xiajia success:(ETResponseBlock) success faild:(ETResponseErrorBlock) faild;{
    
    NSDictionary *para = @{@"a":@"GetShopGoodList",@"userid":userid,@"shopid":shopid,@"xiajia":(xiajia?:@"")};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
                NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//修改商品名称
- (void)updateGoodsNameWithGoodsId:(NSString *)goodsid goodsName:(NSString *)goodsName success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;{
    NSDictionary *para = @{@"a":@"UpdateGoodsName",@"id":goodsid,@"goodsname":goodsName};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(responseObject);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
//修改商品现价
- (void)updateGoodsPriceWithGoodsId:(NSString *)goodsid goodsprice:(NSString *)price success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateGoodsPrice",@"id":goodsid,@"price":price};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(responseObject);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
//修改商品原价
- (void)updateGoodsOPriceWithGoodsId:(NSString *)goodsid OPrice:(NSString *)price success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateGoodsOPrice",@"id":goodsid,@"oprice":price};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
//修改商品描述
- (void)updateGoodsDescriptionWithGoodsid:(NSString *)goodsid description:(NSString *)description success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateGoodsDescription",@"id":goodsid,@"description":description};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//修改商品品牌
- (void)updateGoodsBrandWithGoodsid:(NSString *)goodsid band:(NSString *)band success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateGoodsBand",@"id":goodsid,@"band":band};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
//修改商品类型
- (void)updateGoodsTypeWithGoodsid:(NSString *)goodsid type:(NSString *)type success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"UpdateGoodsType",@"id":goodsid,@"type":type};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
//获取商品对应附加属性列表
- (void)getGoodPropertyListWithGoodsType:(NSString *)goodtype success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"GetGoodPropertyList",@"goodstype":goodtype};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//获取单个商品资料
- (void)getGoodsInfoWithGoodsId:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    
    NSDictionary *para = @{@"a":@"GetGoodsInfo",@"id":goodsid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}
//添加购物车
- (void)addShoppingCartWithShopid:(NSString *)shopid goodsid:(NSString *)goodsid goodsnum:(NSString *)goodsnum success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"AddShoppingCart",@"userid":[ETUserInfo sharedETUserInfo].id,@"goodsid":goodsid,@"goodsnum":goodsnum,@"shopid":shopid};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//删除购物车
- (void)deleteShoppingCartWithGoodsid:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"DeleteShoppingCart",@"userid":[ETUserInfo sharedETUserInfo].id,@"goodsid":goodsid};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//获取我的购物车
- (void)getShoppingCartWithUserid:(NSString *)userid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"GetShoppingCart",@"userid":[ETUserInfo sharedETUserInfo].id};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpArrayModel *model = [ETHttpArrayModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [ETShopCartModel mj_objectArrayWithKeyValuesArray:model.data];
            
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//删除产品
- (void)deleteGoodsWithGoodsid:(NSString *)goodid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"DeleteGoods",@"id":goodid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
           
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
//获取订单列表
-(void) getOrderListInfoWithUserid:(NSString *)userid success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    
    NSDictionary *para = @{@"a":@"getshoppingorderlist",@"userid":userid};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
    
}


@end