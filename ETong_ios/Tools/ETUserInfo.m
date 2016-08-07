//
//  ETUserInfo.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETUserInfo.h"

@implementation ETUserInfo
singleton_implementation(ETUserInfo)
-(void)setId:(NSString *)id{
    if(id&&id.length > 0)
    _isLogin = true;
    _id = id;
}
@end
