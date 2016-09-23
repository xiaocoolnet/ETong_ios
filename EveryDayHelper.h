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


@end
