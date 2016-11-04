//
//  JSCartCell.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartCell.h"
#import "JSNummberCount.h"
#import "JSCartModel.h"

@interface JSCartCell ()

@property (weak, nonatomic) IBOutlet UILabel        *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *GoodsPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (nonatomic, strong) NSString *typenameStr;
@property (nonatomic,strong) NSString *propertynameStr;

@end

@implementation JSCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setModel:(JSCartModel *)model{
    
    self.goodsNameLabel.text             = model.p_name;
    self.GoodsPricesLabel.text           = [NSString stringWithFormat:@"￥%.2f",model.p_price];
    self.nummberCount.totalNum           = model.p_stock;
    self.nummberCount.currentCountNumber = model.p_quantity;
    self.selectShopGoodsButton.selected  = model.isSelect;
    self.nummberCount.shopid = model.p_id;
    NSString *typename = [model.s_property.firstObject[@"propert_list"] firstObject][@"typename"];
    NSString *propertyname = [model.s_property.firstObject[@"propert_list"] firstObject][@"propertyname"];
    if (model.s_property.count >= 2) {
    
        self.typenameStr = [model.s_property[2][@"propert_list"] firstObject][@"typename"];
        self.propertynameStr = [model.s_property[2][@"propert_list"] firstObject][@"propertyname"];
        self.typeLab.text = [NSString stringWithFormat:@"%@:%@ %@:%@",typename,propertyname,self.typenameStr,self.propertynameStr];
    }
//    if (model.s_property.count == 1) {
//        self.typeLab.text = [NSString stringWithFormat:@"%@:%@",typename,propertyname];
//    }
   
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.p_imageUrl]];
}

+ (CGFloat)getCartCellHeight{
    return 100;
}

@end
