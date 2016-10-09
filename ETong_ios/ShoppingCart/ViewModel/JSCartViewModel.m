//
//  JSCartViewModel.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartViewModel.h"
#import "JSCartModel.h"
#import "ETShopHelper.h"
#import "ETShopCartModel.h"

@interface JSCartViewModel (){
    NSArray *_shopGoodsCount;
    NSArray *_goodsPicArray;
    NSArray *_goodsPriceArray;
    NSArray *_goodsQuantityArray;
}

//随机获取店铺下商品数
@property (nonatomic, assign) NSInteger random;
@end

@implementation JSCartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //6
        _shopGoodsCount  = @[@(1),@(8),@(5),@(2),@(4),@(4)];
        _goodsPicArray  = @[@"http://pic.5tu.cn/uploads/allimg/1606/pic_5tu_big_2016052901023305535.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_2016052901023303745.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_201605291711245481.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_2016052901023285762.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1506/091630516760.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1506/091630516760.jpg"];
        _goodsPriceArray = @[@(30.45),@(120.09),@(7.8),@(11.11),@(56.1),@(12)];
        _goodsQuantityArray = @[@(12),@(21),@(1),@(10),@(3),@(5)];
    }
    return self;
}

- (NSInteger)random{
    
    NSInteger from = 0;
    NSInteger to   = 5;
    
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

#pragma mark - make data

- (void)getData{
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    
    ETShopHelper *helper = [[ETShopHelper alloc]init];
    
    __block NSInteger allGoodsCount = 0;
    __block NSMutableArray *storeArray = [NSMutableArray array];
    __block NSMutableArray *shopSelectAarry = [NSMutableArray array];
    WEAKSELF
    [helper getShoppingCartWithUserid:[ETUserInfo sharedETUserInfo].id success:^(NSDictionary *response) {
        NSArray *cartModels = response[@"cartGoods"];
        //把ETShopCartModel转成JSCartModel
        [cartModels enumerateObjectsUsingBlock:^(ETShopCartModel *obj, NSUInteger idx, BOOL * stop) {
            NSMutableArray *goodsArray = [NSMutableArray array];
            for (ETGoodsDataModel *good in obj.goodslist) {
                JSCartModel *cartModel = [good converToJSCartModel];
                cartModel.s_id = obj.shopid;
                cartModel.s_name = obj.shopname;
                [goodsArray addObject:cartModel];
                allGoodsCount++;
            }
            [storeArray addObject:goodsArray];
            [shopSelectAarry addObject:@(NO)];
        }];
        weakSelf.shopSelectArray = shopSelectAarry;
        weakSelf.cartGoodsCount = allGoodsCount;
        weakSelf.cartData = storeArray;//这里kvo发送信号刷新页面
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
}

- (float)getAllPrices{
    
    __block float allPrices   = 0;
    NSInteger shopCount       = self.cartData.count;
    NSInteger shopSelectCount = self.shopSelectArray.count;
    if (shopSelectCount == shopCount && shopCount!=0) {
        self.isSelectAll = YES;
    }
    NSArray *pricesArray = [[[self.cartData rac_sequence] map:^id(NSMutableArray *value) {
        return [[[value rac_sequence] filter:^BOOL(JSCartModel *model) {
            if (!model.isSelect) {
                self.isSelectAll = NO;
            }
            return model.isSelect;
        }] map:^id(JSCartModel *model) {
            return @(model.p_quantity*model.p_price);
//            return @(model.p_name);
        }];
    }] array];
    for (NSArray *priceA in pricesArray) {
        for (NSNumber *price in priceA) {
            allPrices += price.floatValue;
        }
    }
    
    return allPrices;
}

- (void)selectAll:(BOOL)isSelect{
    
     __block float allPrices = 0;
    
    self.shopSelectArray = [[[[self.shopSelectArray rac_sequence] map:^id(NSNumber *value) {
        return @(isSelect);
    }] array] mutableCopy];
    self.cartData = [[[[self.cartData rac_sequence] map:^id(NSMutableArray *value) {
        return  [[[[value rac_sequence] map:^id(JSCartModel *model) {
                [model setValue:@(isSelect) forKey:@"isSelect"];
            if (model.isSelect) {
                allPrices += model.p_quantity*model.p_price;
            }
            return model;
        }] array] mutableCopy];
    }] array] mutableCopy];
    self.allPrices = allPrices;
    [self.cartTableView reloadData];
}

- (void)rowSelect:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section          = indexPath.section;
    NSInteger row              = indexPath.row;

    NSMutableArray *goodsArray = self.cartData[section];
    NSInteger shopCount        = goodsArray.count;
    JSCartModel *model         = goodsArray[row];
    [model setValue:@(isSelect) forKey:@"isSelect"];
    //判断是都到达足够数量
    NSInteger isSelectShopCount = 0;
    for (JSCartModel *model in goodsArray) {
        if (model.isSelect) {
            isSelectShopCount++;
        }
    }
    [self.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelectShopCount==shopCount?YES:NO)];
    
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

- (void)rowChangeQuantity:(NSInteger)quantity indexPath:(NSIndexPath *)indexPath{
    
    NSInteger section  = indexPath.section;
    NSInteger row      = indexPath.row;

    JSCartModel *model = self.cartData[section][row];
    [model setValue:@(quantity) forKey:@"p_quantity"];
    NSString *num = [NSString stringWithFormat: @"%@", @(quantity)];
    NSString *goodsid = model.p_id;
    ETShopHelper *helper = [[ETShopHelper alloc]init];
    [helper changeShoppingCartWithUserid:[ETUserInfo sharedETUserInfo].id goodsid:goodsid goodsnum:num success:^(NSDictionary *response) {
        [SVProgressHUD showSuccessWithStatus:@"结算成功"];
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"结算失败"];
    }];
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

-(void)changeGoodsnum{
    ETShopHelper *helper = [[ETShopHelper alloc]init];
    
    [helper changeShoppingCartWithUserid:[ETUserInfo sharedETUserInfo].id goodsid:@"" goodsnum:@"" success:^(NSDictionary *response) {
        
    } faild:^(NSString *response, NSError *error) {
        
    }];

}

//左滑删除商品
- (void)deleteGoodsBySingleSlide:(NSIndexPath *)path{
    
    NSInteger section = path.section;
    NSInteger row     = path.row;
    
    NSMutableArray *shopArray = self.cartData[section];
    [shopArray removeObjectAtIndex:row];
    if (shopArray.count == 0) {
        /*1 删除数据*/
        [self.cartData removeObjectAtIndex:section];
        /*2 删除 shopSelectArray*/
        [self.shopSelectArray removeObjectAtIndex:section];
        [self.cartTableView reloadData];
    } else {
        [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
    self.cartGoodsCount-=1;
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

//选中删除
- (void)deleteGoodsBySelect{
    /*1 删除数据*/
    NSInteger index1 = -1;
    NSMutableIndexSet *shopSelectIndex = [NSMutableIndexSet indexSet];
    for (NSMutableArray *shopArray in self.cartData) {
        index1++;
        NSInteger index2 = -1;
        NSMutableIndexSet *selectIndexSet = [NSMutableIndexSet indexSet];
        for (JSCartModel *model in shopArray) {
            index2++;
            if (model.isSelect) {
                [selectIndexSet addIndex:index2];
            }
        }
        NSInteger shopCount = shopArray.count;
        NSInteger selectCount = selectIndexSet.count;
        if (selectCount == shopCount) {
            [shopSelectIndex addIndex:index1];
            self.cartGoodsCount-=selectCount;
        }
        [shopArray removeObjectsAtIndexes:selectIndexSet];
    }
    [self.cartData removeObjectsAtIndexes:shopSelectIndex];
    /*2 删除 shopSelectArray*/
    [self.shopSelectArray removeObjectsAtIndexes:shopSelectIndex];
    [self.cartTableView reloadData];
    /*3 carbar 恢复默认*/
    self.allPrices = 0;
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}


@end
