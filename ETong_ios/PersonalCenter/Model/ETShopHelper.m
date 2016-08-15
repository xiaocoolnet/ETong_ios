//
//  ETShopHelper.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETShopHelper.h"
#import "ETGoodsDataModel.h"

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
    
    NSDictionary *para = @{@"a":@"UpdateUserAddress",@"userid":[ETUserInfo sharedETUserInfo].id,@"shopid":model.shopid,@"piclist":model.piclist,@"goodsname":model.goodsname,@"type":model.type,@"oprice":model.oprice,@"price":model.price,@"description":model.description,@"unit":model.unit,@"address":model.address,@"longitude":model.longitude,@"latitude":model.latitude,@"freight":model.freight,@"band":model.brand};
    
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
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

@end
