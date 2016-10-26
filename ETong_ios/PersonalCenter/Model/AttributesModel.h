//
//  AttributesModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributesModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *typeid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *propertylist;
@property (nonatomic, copy) NSString *termid;
@property (nonatomic, copy) NSString *listorder;
@property (nonatomic, strong) NSArray *plist;

@end
