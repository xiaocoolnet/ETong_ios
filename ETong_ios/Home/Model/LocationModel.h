//
//  LocationModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *businesslicense;

@property (nonatomic, copy) NSString *id_positive_pic;

@property (nonatomic, copy) NSString *license_pic;

@property (nonatomic, copy) NSString *id_opposite_pic;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *idcard;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *contactphone;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, strong) NSArray *goodslist;

@property (nonatomic, copy) NSString *photo;


@end

