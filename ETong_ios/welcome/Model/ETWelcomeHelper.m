//
//  ETWelcomeHelper.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETWelcomeHelper.h"
#import "ETUserInfo.h"
@implementation ETWelcomeHelper

- (void)loginWithPhoneNumber:(NSString *)phoneNum
                     PassWord:(NSString *)pwd
                      success:(ETResponseBlock)success
                        faild:(ETResponseErrorBlock)faild;{
    NSDictionary *para = @{@"a":@"applogin",@"phone":phoneNum,@"password":pwd};
    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            [ETUserInfo mj_objectWithKeyValues:model.data];
            [ETUserInfo sharedETUserInfo].isLogin = true;
//            [[NSUserDefaults standardUserDefaults] setValue:[ETUserInfo sharedETUserInfo].id forKey:USER_ID];
//            [[NSUserDefaults standardUserDefaults] setValue:[ETUserInfo sharedETUserInfo].name forKey:USERNAME];
//            [[NSUserDefaults standardUserDefaults] setValue:[ETUserInfo sharedETUserInfo].photo forKey:USER_PHOTO];
//            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"login"];
//             NSLog(@"ssaaa=%@",[ETUserInfo sharedETUserInfo].id);
//            NSLog(@"sss=%@",[[NSUserDefaults standardUserDefaults] stringForKey:USER_ID]);
            success(responseObject);
        }else{
            faild(@"登录失败",nil);
        }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            faild(error.description,nil);
        }];
}
//不可用
-(void)uploadImageWithData:(NSData *)imageData
                 imageName:(NSString *)imageName
                   success:(ETResponseBlock)success
                     faild:(ETResponseErrorBlock)faild;{
    [self.manager POST:kUPLOAD_URL_HEAD parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"upfile" fileName:imageName mimeType:@"image/*"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)sendMobileCodeWithPhone:(NSString *)phoneNumber success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock) faild;{
    [self.manager GET:kURL_HEAD parameters:@{@"a":@"SendMobileCode",@"phone":phoneNumber} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(responseObject);
            
        }else{
            faild(@"",nil);
            NSLog(@"23456765432");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,error);
        NSLog(@"aaaaaaa");
    }];
    NSLog(@"%@",phoneNumber);
}

- (void)registerWithPhone:(NSString *)phoneNumber
                 password:(NSString *)pwd
                     code:(NSString *)code
              devicestate:(NSString *)state
                  success:(ETResponseBlock)success
                    faild:(ETResponseErrorBlock)faild;{
    [self.manager GET:kURL_HEAD parameters:@{@"a":@"AppRegister",@"phone":phoneNumber,@"password":pwd,@"code":code,@"devicestate":state} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,error);
    }];
}

- (void)changePasswordWithPhone:(NSString *)phoneNumber
                           code:(NSString *)code
                       password:(NSString *)pwd
                        success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock) faild;{
    [self.manager GET:kURL_HEAD parameters:@{@"phone":phoneNumber,@"code":code,@"password":pwd} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            success(responseObject);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,error);
    }];
}

@end
