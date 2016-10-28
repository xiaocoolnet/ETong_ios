//
//  SortView.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SortPickerDelegate <NSObject>
@optional
- (void)JSAddressPickerRerurnBlockWithProvince:(NSString *)province
                                          city:(NSString *)city town:(NSString *)town;
- (void)JSAddressCancleAction:(id)senter;
@end

@interface SortView : UIView
@property (nonatomic, weak) id<SortPickerDelegate> delegate;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *town;

//- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
/** 内容字体 */
@property (nonatomic, strong) UIFont *font;

@end
