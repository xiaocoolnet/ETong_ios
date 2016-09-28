//
//  NewsModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *my_face;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *chat_uid;

@property (nonatomic, copy) NSString *my_nickname;

@property (nonatomic, copy) NSString *other_face;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *other_nickname;

@property (nonatomic, copy) NSString *last_content;

@property (nonatomic, copy) NSString *last_chat_id;


@end
