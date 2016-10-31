//
//  ETWelcomeHelper.h
//  ETong_ios
//
//  Created by xiaocool on 16/7/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETBaseHelper.h"

@interface ETWelcomeHelper : ETBaseHelper
/**
 *  登录
 *  @param phoneNum 手机号
 *  @param pwd      密码
 */
- (void)loginWithPhoneNumber:(NSString *)phoneNum
                     PassWord:(NSString *)pwd
                      success:(ETResponseBlock)success
                        faild:(ETResponseErrorBlock)faild;
/**
 *  上传图片
 *  @param imageData 图片二进制数据
 *  @param name      图片名称
 *  @param success   上传成功回调
 *  @param faild     上传失败回调
 */
- (void)uploadImageWithData:(NSData *)imageData
                 imageName:(NSString *)name
                   success:(ETResponseBlock)success
                     faild:(ETResponseErrorBlock)faild;
/**
 *  发送验证码
 *  @param phoneNumber 手机号
 */
- (void)sendMobileCodeWithPhone:(NSString *)phoneNumber success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock) faild;
/**
 *  注册
 *  @param phoneNumber 手机号
 *  @param pwd         密码
 *  @param code        验证码
 *  @param state       状态
 */
- (void)registerWithPhone:(NSString *)phoneNumber
                 password:(NSString *)pwd
                     code:(NSString *)code
              devicestate:(NSString *)state
                  success:(ETResponseBlock)success
                    faild:(ETResponseErrorBlock)faild;
/**
 *  修改密码
 *  @param phoneNumber 电话号码
 *  @param code        验证码
 *  @param pwd         密码
 *  @param success     成功
 *  @param faild       失败
 */
- (void)changePasswordWithPhone:(NSString *)phoneNumber
                           code:(NSString *)code
                       password:(NSString *)pwd
                        success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock) faild;
@end
