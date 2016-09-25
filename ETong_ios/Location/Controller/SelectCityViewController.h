//
//  SelectCityViewController.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassTrendValueDelegate <NSObject>
@optional
- (void)passTrendValues:(NSString *)city;

@end

@interface SelectCityViewController : UIViewController

@property (nonatomic, weak) id<PassTrendValueDelegate> delegate;

@end
