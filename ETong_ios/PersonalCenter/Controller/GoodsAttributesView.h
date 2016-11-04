//
//  GoodsAttributesView.h
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsAttributesView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString *goodid;
@property (nonatomic, strong) NSString *shopid;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *iconImgView;
@property (nonatomic, weak) UILabel *goodsNameLbl;
@property (nonatomic, weak) UILabel *goodsPriceLbl;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) ETShopHelper *help;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *imgStr;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *proidStr;
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 购买数量 */
@property (nonatomic, assign) int buyNum;
/** 购买数量Lbl */
@property (nonatomic, weak) UILabel *buyNumsLbl;


/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;
/**
 *  属性视图的消失
 */
- (void)removeView;

@property (nonatomic, copy) void (^sureBtnsClick)(NSString *num, NSString *attr_id);

@end
