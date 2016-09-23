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


@end
