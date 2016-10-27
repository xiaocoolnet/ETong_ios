
//
//  JSCartModel.h
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSCartModel : NSObject

@property (nonatomic, copy) NSString *p_id;

@property (nonatomic, assign) float   p_price;

@property (nonatomic, copy) NSString *o_price;

@property (nonatomic, copy) NSString *p_name;

@property (nonatomic, copy) NSString  *p_imageUrl;

@property (nonatomic, assign) NSInteger p_stock;

@property (nonatomic, assign) NSInteger p_quantity;

@property (nonatomic, copy) NSString *s_id;

@property (nonatomic, copy) NSString *s_name;

//商品是否被选中
@property (nonatomic, assign) BOOL isSelect;

@end
