//
//  EvaluateModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Goods_Infos;
@interface EvaluateModel : NSObject


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *add_time;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *finishscore;

@property (nonatomic, strong) NSArray<Goods_Infos *> *goods_info;

@property (nonatomic, copy) NSString *orderid;

@property (nonatomic, copy) NSString *receivetype;

@property (nonatomic, copy) NSString *attitudescore;

@property (nonatomic, copy) NSString *effectscore;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *content;


@end
@interface Goods_Infos : NSObject

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *picture;

@end

