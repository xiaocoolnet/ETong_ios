//
//  ClassificationView.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(NSString *title);

@interface ClassificationView : UIView

@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, copy)NSString *textTitle;
@property (nonatomic, copy)selectBlock finishBlock;

@end
