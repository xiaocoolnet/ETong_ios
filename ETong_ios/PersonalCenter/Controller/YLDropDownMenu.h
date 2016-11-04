//
//  YLDropDownMenu.h
//  YLDrowDownMenu
//
//  Created by Bing on 16/6/29.
//  Copyright © 2016年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(NSString *title);
typedef void(^selectBlock) (NSString *row);

@interface YLDropDownMenu : UIView

@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, copy)NSString *textTitle;
@property (nonatomic, copy)selectBlock finishBlock;
@property (nonatomic, strong) selectBlock finishRow;

@end
