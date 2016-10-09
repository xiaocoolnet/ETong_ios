//
//  EBuyingViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "EBuyingViewController.h"
#import "AllEBuyingViewController.h"
#import "DistanceAllBuyingViewController.h"

@interface EBuyingViewController ()

@end

@implementation EBuyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    [self configureUI];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 88, kScreenWidth, self.view.frame.size.height - 64 - 88)];
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
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(0, 44, self.view.frame.size.width, 44);
    lable.text = @"距结束仅剩02：02：02";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor colorWithRed:253/255.0 green:74/255.0 blue:75/255.0 alpha:1.0];
    [self.view addSubview:lable];
}

- (void)initViewControllers {
    AllEBuyingViewController *controller1 = [[AllEBuyingViewController alloc] init];
    controller1.yp_tabItemTitle = @"全城";
    
    DistanceAllBuyingViewController *controller2 = [[DistanceAllBuyingViewController alloc] init];
    controller2.yp_tabItemTitle = @"距离";
    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
    
}


@end
