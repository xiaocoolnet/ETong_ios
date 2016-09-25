//
//  JSAddressPickerView.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSAddressPickerDelegate <NSObject>
@optional
- (void)JSAddressPickerRerurnBlockWithProvince:(NSString *)province
                                          city:(NSString *)city;
- (void)JSAddressCancleAction:(id)senter;
@end

@interface JSAddressPickerView : UIView
@property (nonatomic, weak) id<JSAddressPickerDelegate> delegate;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;

- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city;
/** 内容字体 */
@property (nonatomic, strong) UIFont *font;
@end

