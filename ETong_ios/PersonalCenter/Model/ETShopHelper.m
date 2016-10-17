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
//            NSArray *models = [ETGoodsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            success(@{@"goods":models});
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
            success(@{@"cartGoods":models});
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

//获取收藏列表
-(void)getCollectListInfoWithUserid:(NSString *)userid Type:(NSString *)type success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"getfavoritelist",@"userid":userid,@"type":type};
    
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

//获取评论列表
-(void)getEvaluateListInfoWithUserid:(NSString *)userid Type:(NSString *)type success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetMyEvaluatelists",@"userid":userid,@"type":type};
    
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
// 获取聊天列表
-(void)getNewsListInfoWithUserid:(NSString *)userid success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"xcGetChatListData",@"uid":userid};
    
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

// 购物车购买商品
-(void)PayInfoWithUserid:(NSString *)userid peoplename:(NSString *)peoplename address:(NSString *)address goodsid:(NSString *)goodsid goodnum:(NSString *)goodnum mobile:(NSString *)mobile remark:(NSString *)remark money:(NSString *)money success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"bookingshopping",@"userid":userid,@"peoplename":peoplename,@"address":address,@"goodsid":goodsid,@"goodnum":goodnum,@"mobile":mobile,@"remark":remark,@"money":money};
    
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        faild("")
    }];
}

// 修改商品数量
-(void)changeShoppingCartWithUserid:(NSString *)userid goodsid:(NSString *)goodsid goodsnum:(NSString *)goodsnum success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"EditShoppingCart",@"userid":userid,@"goodsid":goodsid,@"goodsnum":goodsnum};
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

// 取消订单
-(void)cancleOrderWithid:(NSString *)goodsid reason:(NSString *)reason success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"DeleteOrder",@"id":goodsid,@"reason":reason};
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

// 支付订单
-(void)payOrderWithid:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"DeleteOrder",@"id":goodsid};
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

// 评价商品订单
-(void)evaluateOrderWithUserid:(NSString *)userid Orderid:(NSString *)orderid Type:(NSString *)type Content:(NSString *)content Attitudescore:(NSString *)attitudescore Finishscore:(NSString *)finishscore Effectscore:(NSString *)effectscore success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"BuyerSetEvaluate",@"userid":userid,@"orderid":orderid,@"type":type,@"content":content,@"attitudescore":attitudescore,@"finishscore":finishscore,@"effectscore":effectscore};
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

// 取消收藏
-(void)cancleCollectionWithUserid:(NSString *)userid goodsid:(NSString *)goodsid type:(NSString *)type success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"cancelfavorite",@"userid":userid,@"goodsid":goodsid,@"type":type};
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

// 收藏商品
-(void)collectionGoodsWithUserid:(NSString *)userid goodsid:(NSString *)goodsid type:(NSString *)type title:(NSString *)title description:(NSString *)description success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"addfavorite",@"userid":userid,@"goodsid":goodsid,@"type":type,@"title":title,@"description":description};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
            NSLog(@"%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}

//下架店铺商品
-(void)SoldOutGoodsWithGoodsid:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GoodsXiajia",@"id":goodsid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
            NSLog(@"%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

//上架店铺商品
-(void)AddedGoodsWithGoodsid:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GoodsShangjia",@"id":goodsid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
            NSLog(@"%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

//删除店铺商品
-(void)DeleteGoodsWithGoodsid:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"DeleteGoods",@"id":goodsid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
            NSLog(@"%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

// 我的足迹列表
-(void)GetFootprintsWithUserid:(NSString *)userid Type:(NSString *)type success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetMyBrowseHistory",@"userid":userid,@"type":type};
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

//获取聊天信息
-(void)GetTalkNewsWithUserid:(NSString *)send_uid Receive_uid:(NSString *)receive_uid success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"xcGetChatData",@"send_uid":send_uid,@"receive_uid":receive_uid};
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

//发送聊天信息
-(void)SendTalkNewsWithUserid:(NSString *)send_uid Receive_uid:(NSString *)receive_uid Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"SendChatData",@"send_uid":send_uid,@"receive_uid":receive_uid,@"content":content};
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

//获取店铺信息
-(void)GetShopDetailsWithShopid:(NSString *)shopid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetShopInfo",@"shopid":shopid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(model.data);
        }else{
            faild(@"", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

//获取订单列表(swift)
-(void)GetOrderListInfoWithUserid:(NSString *)userid state:(NSString *)state success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"getshoppingorderlist",@"userid":userid,@"state":state};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

//获取订单列表全部(swift)
-(void)GetOrderListInfoWithUserid:(NSString *)userid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"getshoppingorderlist",@"userid":userid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

// 获取我的店铺订单列表全部(swift)
-(void)GetMyShopOrderListInfoWithShopid:(NSString *)shopid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"Shopgetorderlist",@"shopid":shopid};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

// 获取我的店铺订单列表(swift)
-(void)GetMyShopOrderListInfoWithShopid:(NSString *)shopid state:(NSString *)state success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"Shopgetorderlist",@"shopid":shopid,@"state":state};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            NSArray *models = [OrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            success(@{@"goods":models});
        }else{
            faild(@"", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}


@end