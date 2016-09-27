//
//  OrderListModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Evaluate;
@interface OrderListModel : NSObject


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *statusname;

@property (nonatomic, copy) NSString *statusend;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *peoplename;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, strong) Evaluate *evaluate;

@property (nonatomic, copy) NSString *order_num;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *goodsname;


@end
@interface Evaluate : NSObject

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *effectscore;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *receivetype;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *orderid;

@property (nonatomic, copy) NSString *attitudescore;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *finishscore;

@end

