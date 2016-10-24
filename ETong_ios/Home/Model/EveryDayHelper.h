//
//  EveryDayHelper.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETBaseHelper.h"

@interface EveryDayHelper : ETBaseHelper


/**
 *  获取每日好店
 */
- (void)getGoodShopInfoWithType:(NSString *)type
                        success:(ResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;
/**
 *  获取猜你喜欢
 */
- (void)getGoodShopInfoWithIsLike:(NSString *)isLike
                        success:(ResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;
/**
 *  获取新品上市
 */
- (void)getNewProductInfoWithRecommend:(NSString *)recommend
                          success:(ResponseBlock)success
                            faild:(ETResponseErrorBlock)faild;

/**
 *  获取每日好店店铺商品
 */
- (void)getGoodShopInfoWithShopid:(NSString *)shopid Userid:(NSString *)userid
                        success:(ResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;
/**
 *  本地e抢购（全城）
 */
- (void)success:(ResponseBlock)success
                            faild:(ETResponseErrorBlock)faild;
/**
 *  本地今日特价
 */
- (void)NowDaysuccess:(ResponseBlock)success
          faild:(ETResponseErrorBlock)faild;

/**
 *  本地新客专享
 */
- (void)NewPeoplesuccess:(ResponseBlock)success
                   faild:(ETResponseErrorBlock)faild;

/**
 *  本地美食
 */
- (void)getfoodsInfoWithCity:(NSString *)city Type:(NSString *)type
                          success:(ResponseBlock)success
                            faild:(ETResponseErrorBlock)faild;
/**
 *  搜索商品列表(首页)
 */
- (void)GetSearchGoodsInfoWithGoods:(NSString *)goods
                           success:(ETResponseBlock)success
                             faild:(ETResponseErrorBlock)faild;

/**
 *  搜搜商品列表排序(首页)
 */
- (void)GetSearchGoodsInfoWithGoods:(NSString *)goods sort:(NSString *)sort
                            success:(ETResponseBlock)success
                              faild:(ETResponseErrorBlock)faild;

/**
 *  首页分类一级列表
 */
- (void)getGoodsListsuccess:(ResponseBlock)success
                          faild:(ETResponseErrorBlock)faild;


@end
