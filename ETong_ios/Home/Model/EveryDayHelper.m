//
//  EveryDayHelper.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "EveryDayHelper.h"

@implementation EveryDayHelper

- (void)getGoodShopInfoWithType:(NSString *)type
                        success:(ResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;{
    
    NSDictionary *para = @{@"a":@"GetDayShop",@"type":type};
    
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

- (void)getGoodShopInfoWithIsLike:(NSString *)isLike
                        success:(ResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;{
    
    NSDictionary *para = @{@"a":@"IsLike"};
    
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

-(void)getNewProductInfoWithRecommend:(NSString *)recommend success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetHotGoodList",@"recommend":recommend};
    
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

-(void) getGoodShopInfoWithShopid:(NSString *)shopid Userid:(NSString *)userid success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    
    NSDictionary *para = @{@"a":@"GetShopGoodList",@"shopid":shopid,@"userid":userid};
    
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

-(void)success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"IsE"};
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

-(void)NowDaysuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"IsPrice"};
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
#pragma mark - 本地新客专享
-(void)NewPeoplesuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"IsNew"};
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
#pragma mark - 本地美食
-(void)getfoodsInfoWithCity:(NSString *)city Type:(NSString *)type success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetShopList",@"city":city,@"type":type};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
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

#pragma mark - 搜索商品首页
-(void)GetSearchGoodsInfoWithGoods:(NSString *)goods success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"SearchGoods",@"goods":goods};
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

#pragma mark - 搜索商品排序首页
-(void)GetSearchGoodsInfoWithGoods:(NSString *)goods sort:(NSString *)sort success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"SearchGoods",@"goods":goods,@"sort":sort};
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

#pragma mark -首页分类一级列表
-(void)getGoodsListsuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetMenu"};
    
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

#pragma mark - 首页二级分类列表
-(void)getSecondGoodsListInfoWithName:(NSString *)levelone_name success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetMenu",@"levelone_name":levelone_name};
    
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

#pragma mark -首页三级列表数据
-(void)getSecondGoodsListInfoWithname:(NSString *)leveltwo_name success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *para = @{@"a":@"GetMenu",@"leveltwo_name":leveltwo_name};
    
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
