//
//  ETShopHelper.h
//  ETong_ios
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETBaseHelper.h"

@class ETGoodsDataModel;

@interface ETShopHelper : ETBaseHelper
/**
 *  提交开店数据
 */
- (void)upDataCreatShopInfoWithUserid:(NSString *)userid city:(NSString *)city shopName:(NSString *)shopName legalperson:(NSString *)legalPerson phone:(NSString *)phone type:(NSString *)type businesslicense:(NSString *)businesslicense address:(NSString *)address idcard:(NSString *)idcard positive_pic:(NSString *)positive_pic opposite_pic:(NSString *)opposite_pic license_pic:(NSString *)license_pic success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
/**
 *  获取我的店铺
 */
- (void)getMyShopInfoWithUserid:(NSString *)userid
                        success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;
/**
 *  修改头像
 */
- (void)updataUserAvatarWithUserid:(NSString *)userid avatar:(NSString *)avatar success:(ETResponseBlock) success
                       faild:(ETResponseErrorBlock) faild;
/**
 *  修改姓名
 */
- (void)updataUserNameWithUserid:(NSString *)userid Nicename:(NSString *)nicename success:(ETResponseBlock) success
                           faild:(ETResponseErrorBlock)faild;
/**
 *  修改性别
 *  @param sex     0-女 1-男
 */
- (void)updataUserSexWithUserid:(NSString *)userid sex:(NSNumber *)sex success:(ETResponseBlock) success
                          faild:(ETResponseErrorBlock)faild;
/**
 *  修改手机号
 */
- (void)updataUserPhone:(NSString *)phone userid:(NSString *)userid code:(NSString *)code success:(ETResponseBlock) success faild:(ETResponseErrorBlock)faild;
/**
 *  修改地址
 */
- (void)updataUserAddress:(NSString *)address userid:(NSString *)userid success:(ETResponseBlock) success faild:(ETResponseErrorBlock)faild;
/**
 *  上传宝贝
 *
 *  @param model   商品model
 */
- (void)uploadGoodsWithGoodsModel:(ETGoodsDataModel *)model success:(ETResponseBlock) success faild:(ETResponseErrorBlock) faild;
/**
 *  获取店铺商品
 *
 *  @param shopid 店铺ID
 *  @param userid 用户ID
 *  @param xiajia 选填 1表示获取下架列表
 */
- (void)getShopGoodsListWithShopid:(NSString *)shopid userid:(NSString *)userid xiajia:(NSString *)xiajia success:(ETResponseBlock) success faild:(ETResponseErrorBlock) faild;

@end
