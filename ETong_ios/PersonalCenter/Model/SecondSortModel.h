//
//  SecondSortModel.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondSortModel : NSObject

@property (nonatomic, copy) NSString *term_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger haschild;

@property (nonatomic, strong) NSArray *childlist;

@end
