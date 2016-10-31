//
//  GoodsAttributesView.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "GoodsAttributesView.h"
#import "UIButton+Bootstrap.h"
#import "GoodAttrModel.h"
#import "UIImageView+WebCache.h"
#import "GlobalDefine.h"
#import "ETShopHelper.h"
#import "AttributesCollectionViewCell.h"

@implementation GoodsAttributesView

-(ETShopHelper *)help{
    if (!_help) {
        _help = [ETShopHelper helper];
    }
    return _help;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
        
        [self setupBasicView];
        [self addBuyGoodNum];
//        [self getGoodsData];
    }
    return self;
}

-(void)setupBasicView{
    // 添加手势，点击背景视图消失
    /** 使用的时候注意名字不能用错，害我定格了几天才发现。FK(哈哈，菜B)
     UIGestureRecognizer
     UITapGestureRecognizer // 点击手势
     UISwipeGestureRecognizer // 轻扫手势
     */
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tapBackGesture];
    
    UIView *contentView = [[UIView alloc] initWithFrame:(CGRect){0, kScreenH - kATTR_VIEW_HEIGHT, kScreenW, kATTR_VIEW_HEIGHT}];
    contentView.backgroundColor = [UIColor whiteColor];
    // 添加手势，遮盖整个视图的手势，
    UITapGestureRecognizer *contentViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [contentView addGestureRecognizer:contentViewTapGesture];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    UIView *iconBackView = [[UIView alloc] initWithFrame:(CGRect){10, -15, 90, 90}];
    iconBackView.backgroundColor = kWhiteColor;
    iconBackView.layer.borderColor = LXBorderColor.CGColor;
    iconBackView.layer.borderWidth = 1;
    iconBackView.layer.cornerRadius = 3;
    [contentView addSubview:iconBackView];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 80, 80}];
    [iconImgView setImage:[UIImage imageNamed:@"hdl"]];
    [iconBackView addSubview:iconImgView];
    self.iconImgView = iconImgView;
    
    UIButton *XBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    XBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
    [XBtn setBackgroundImage:[UIImage imageNamed:@"逆购网app产品说明选择颜色尺寸弹窗"] forState:UIControlStateNormal];
    [XBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:XBtn];
    
    UILabel *goodsNameLbl = [[UILabel alloc] init];
    goodsNameLbl.text = @"商品名字";
    goodsNameLbl.textColor = kMAINCOLOR;
    goodsNameLbl.font = [UIFont systemFontOfSize:15];
    CGFloat goodsNameLblX = CGRectGetMaxX(iconBackView.frame) + 10;
    CGFloat goodsNameLblY = XBtn.frame.origin.y;
    CGSize size = [goodsNameLbl.text sizeWithAttributes:@{NSFontAttributeName:goodsNameLbl.font}];
    
    goodsNameLbl.frame = (CGRect){goodsNameLblX, goodsNameLblY, size};
    [contentView addSubview:goodsNameLbl];
    self.goodsNameLbl = goodsNameLbl;
    
    UILabel *goodsPriceLbl = [[UILabel alloc] initWithFrame:(CGRect){goodsNameLbl.frame.origin.x, CGRectGetMaxY(goodsNameLbl.frame) + 10, 150, 20}];
    goodsPriceLbl.text = @"99元";
    goodsPriceLbl.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:goodsPriceLbl];
    self.goodsPriceLbl = goodsPriceLbl;
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.backgroundColor = kMAINCOLOR;
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"8预约上门时间"] forState:UIControlStateNormal];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.frame = CGRectMake(0, contentView.frame.size.height - 40, kScreenW, 40);
//    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_sureBtn];
    
    [self addCollectionView];
}


-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5; //设置每一行的间距
    layout.itemSize=CGSizeMake((kScreenW - 25)/4.0, 30);  //设置每个单元格的大小
//    layout.sectionInset=UIEdgeInsetsMake(0, 5, 5, 5);
//    layout.headerReferenceSize=CGSizeMake(kScreenW, 200); //设置collectionView头视图的大小
    
    _collection=[[UICollectionView alloc]initWithFrame:(CGRect){0, 90, kScreenW, _sureBtn.frame.origin.y - CGRectGetMaxY(_iconImgView.frame) - 10} collectionViewLayout:layout];
    _collection.frame=CGRectMake(0, 90, kScreenW, _sureBtn.frame.origin.y - CGRectGetMaxY(_iconImgView.frame) - 10 - 80);
    //注册cell单元格
    [self.collection registerClass:[AttributesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
    
    _collection.delegate=self;
    _collection.dataSource=self;
    _collection.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_collection];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    AttributesModel *model = self.dataArray[section];
    return model.propertylist.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AttributesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    AttributesModel *model = self.dataArray[indexPath.section];
    propertyList *modelList = model.propertylist[indexPath.item];
    [cell.btn setTitle:modelList.name forState:UIControlStateNormal];
    cell.btn.titleLabel.font = [UIFont systemFontOfSize:14];
    cell.btn.layer.cornerRadius = 5;
    cell.btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.btn.layer.borderWidth = 0.5;
    [cell.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cell.selected = NO;
    cell.btn.tag = indexPath.section + indexPath.item + 1;
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void) clickbtn:(UIButton *)sender{
    NSLog(@"11233455");
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor redColor];
    }else{
        sender.backgroundColor = [UIColor whiteColor];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        AttributesModel *model = self.dataArray[indexPath.section];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenW - 20, 30)];
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.text = model.name;
        [headerView addSubview:titleLab];
        headerView.backgroundColor = [UIColor whiteColor];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kScreenW,30};
}


- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(0, kScreenH, kScreenW, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(0, kScreenH - kATTR_VIEW_HEIGHT, kScreenW, kATTR_VIEW_HEIGHT);
    }];
}
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(0, kScreenH, kScreenW, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

- (void)setGoodid:(NSString *)goodid{
    _goodid = goodid;
    [self getGoodsData];
}

- (void)setImgStr:(NSString *)imgStr{
    _imgStr = imgStr;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
}

- (void)setNameStr:(NSString *)nameStr{
    _nameStr = nameStr;
    self.goodsNameLbl.text = nameStr;
}

- (void)setPriceStr:(NSString *)priceStr{
    _priceStr = priceStr;
    self.goodsPriceLbl.text = priceStr;
}

- (int)buyNum
{
    if (!_buyNum) {
        self.buyNum = 1;
    }
    return _buyNum;
}


-(void)getGoodsData{
    [self.help GetGoodsAttributesInfoWithgoodsid:self.goodid success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<response.count; i++) {
                
                AttributesModel *model = [AttributesModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
            }
            NSLog(@"%lu",(unsigned long)self.dataArray.count);
            [self.collection reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

-(void) addBuyGoodNum{
    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, CGRectGetMaxY(self.collection.frame), kScreenW-kBigMargin, 1)];
    line2.backgroundColor=HX_RGB(226, 228, 229);
    [self.contentView addSubview:line2];
    
    UILabel *numLab=[[UILabel alloc] initWithFrame:CGRectMake(kSmallMargin, CGRectGetMaxY(line2.frame)+4, 80, kBigMargin)];
    [numLab setText:@"购买数量"];
    numLab.font=kContentTextFont;
    numLab.textColor=HX_RGB(136, 137, 138);
    [self.contentView addSubview:numLab];
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    CGFloat minusBtnWH = 35;
    CGFloat minusBtnX = kBigMargin;
    CGFloat minusBtnY = CGRectGetMaxY(numLab.frame)+15;
    minusBtn.frame = CGRectMake(minusBtnX, minusBtnY, minusBtnWH, minusBtnWH);
    [minusBtn defaultStyleWithNormalTitleColor:[UIColor blackColor] andHighTitleColor:HX_RGB(125, 125, 125) andBorderColor:LXBorderColor andBackgroundColor:HX_RGB(250, 250, 250) andHighBgColor:HX_RGB(220, 220, 220) withcornerRadius:1];
    [minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:minusBtn];
    
    // count
    UILabel *buyNumsLbl = [[UILabel alloc] init];
    buyNumsLbl.text = [NSString stringWithFormat:@"%d", self.buyNum];
    buyNumsLbl.textAlignment = NSTextAlignmentCenter;
    buyNumsLbl.layer.borderWidth = 1;
    buyNumsLbl.layer.borderColor = LXBorderColor.CGColor;
    CGFloat buyNumsLblW = minusBtnWH * 2;
    CGFloat buyNumsLblH = minusBtnWH;
    CGFloat buyNumsLblX = CGRectGetMaxX(minusBtn.frame) - 1;
    CGFloat buyNumsLblY = minusBtnY;
    buyNumsLbl.frame = CGRectMake(buyNumsLblX, buyNumsLblY, buyNumsLblW, buyNumsLblH);
    [self.contentView addSubview:buyNumsLbl];
    self.buyNumsLbl = buyNumsLbl;
    
    // +
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn setTitle:@"+" forState:UIControlStateNormal];
    CGFloat plusBtnWH = 35;
    CGFloat plusBtnX = CGRectGetMaxX(buyNumsLbl.frame);
    CGFloat plusBtnY = minusBtnY;
    plusBtn.frame = CGRectMake(plusBtnX, plusBtnY, plusBtnWH, plusBtnWH);
    [plusBtn defaultStyleWithNormalTitleColor:[UIColor blackColor] andHighTitleColor:HX_RGB(125, 125, 125) andBorderColor:LXBorderColor andBackgroundColor:HX_RGB(250, 250, 250) andHighBgColor:HX_RGB(220, 220, 220) withcornerRadius:1];
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:plusBtn];
}

- (void)minusBtnClick {
    if (self.buyNum == 1) return;
    
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d", --self.buyNum];
}

- (void)plusBtnClick {
    self.buyNumsLbl.text = [NSString stringWithFormat:@"%d", ++self.buyNum];
}

@end
