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

//修改商品名称
- (void)updateGoodsNameWithGoodsId:(NSString *)goodsid goodsName:(NSString *)goodsName success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;
//修改商品现价
- (void)updateGoodsPriceWithGoodsId:(NSString *)goodsid goodsprice:(NSString *)price success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//修改商品原价
- (void)updateGoodsOPriceWithGoodsId:(NSString *)goodsid OPrice:(NSString *)price success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//修改商品描述
- (void)updateGoodsDescriptionWithGoodsid:(NSString *)goodsid description:(NSString *)description success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//修改商品品牌
- (void)updateGoodsBrandWithGoodsid:(NSString *)goodsid band:(NSString *)band success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//修改商品类型
- (void)updateGoodsTypeWithGoodsid:(NSString *)goodsid type:(NSString *)type success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//获取商品对应附加属性列表
- (void)getGoodPropertyListWithGoodsType:(NSString *)goodtype success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//获取单个商品资料
- (void)getGoodsInfoWithGoodsId:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//添加购物车
- (void)addShoppingCartWithShopid:(NSString *)shopid goodsid:(NSString *)goodsid goodsnum:(NSString *)goodsnum success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//删除购物车
- (void)deleteShoppingCartWithGoodsid:(NSString *)goodsid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//获取我的购物车
- (void)getShoppingCartWithUserid:(NSString *)userid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
//删除产品
- (void)deleteGoodsWithGoodsid:(NSString *)goodid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
/**
 *  获取每日好店店铺商品
 */
- (void)getOrderListInfoWithUserid:(NSString *)userid
                          success:(ResponseBlock)success
                            faild:(ETResponseErrorBlock)faild;
/**
 *  获取收藏列表
 */
- (void)getCollectListInfoWithUserid:(NSString *)userid Type:(NSString *)type
                           success:(ResponseBlock)success
                             faild:(ETResponseErrorBlock)faild;
/**
 *  获取评论列表
 */
- (void)getEvaluateListInfoWithUserid:(NSString *)userid Type:(NSString *)type
                             success:(ResponseBlock)success
                               faild:(ETResponseErrorBlock)faild;
/**
 *  获取聊天列表
 */
- (void)getNewsListInfoWithUserid:(NSString *)userid
                           success:(ResponseBlock)success
                             faild:(ETResponseErrorBlock)faild;

/**
 *  购物车购买商品付款
 */
- (void)PayInfoWithUserid:(NSString *)userid peoplename:(NSString *)peoplename address:(NSString *)address goodsid:(NSString *)goodsid goodnum:(NSString *)goodnum mobile:(NSString *)mobile remark:(NSString *)remark money:(NSString *)money success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
/**
 *  购物车购买商品付款
 */
-(void)changeShoppingCartWithUserid:(NSString *)userid goodsid:(NSString *)goodsid goodsnum:(NSString *)goodsnum success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;
/**
 *  取消订单
 */
-(void)cancleOrderWithid:(NSString *)goodsid reason:(NSString *)reason success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

@end
