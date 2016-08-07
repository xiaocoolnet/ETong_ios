//
//  ETShopBeginAuthVC.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETShopBeginAuthVC.h"
#import "ETShopAuthController.h"

@interface ETShopBeginAuthVC ()

@end

@implementation ETShopBeginAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要开店";
    self.hidesBottomBarWhenPushed = true;
}

- (IBAction)authShop:(id)sender{
   ETShopAuthController *vc = [[ETShopAuthController alloc]initWithNibName:@"ETShopAuthController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

@end