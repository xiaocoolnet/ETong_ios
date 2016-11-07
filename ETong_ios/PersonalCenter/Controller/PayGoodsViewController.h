//
//  PayGoodsViewController.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/11/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayGoodsViewController : UIViewController

@property (strong, nonatomic) NSString *goodnum;
@property (nonatomic, strong) ETGoodsDataModel *model;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSString *proidStr;

@end
