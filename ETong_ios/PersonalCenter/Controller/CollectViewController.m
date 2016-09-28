//
//  CollectViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "CollectViewController.h"
#import "BabyCollectViewController.h"
#import "ShopCollectViewController.h"

@interface CollectViewController ()


@end

@implementation CollectViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self configureUI];
    [self initViewControllers];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 44, kScreenWidth, self.view.frame.size.height - 64 - 44)];
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    
    [self.tabBar setScrollEnabledAndItemWidth:kScreenWidth/2];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
    self.tabBar.itemSelectedBgColor = [UIColor redColor];
    [self.tabBar setItemSelectedBgInsets:UIEdgeInsetsMake(42, 0, 0, 0) tapSwitchAnimated:NO];
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    
    
    
}

- (void)configureUI{
    
}

- (void)initViewControllers {
    BabyCollectViewController *controller1 = [[BabyCollectViewController alloc] init];
    controller1.yp_tabItemTitle = @"宝贝";
    
    ShopCollectViewController *controller2 = [[ShopCollectViewController alloc] init];
    controller2.yp_tabItemTitle = @"店铺";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
    
}

@end