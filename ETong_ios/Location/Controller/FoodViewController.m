//
//  FoodViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "FoodViewController.h"
#import "AllFoodViewController.h"
#import "AroundFoodViewController.h"

@interface FoodViewController ()

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    [self configureUI];
    self.title = @"美食";
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 88, kScreenWidth, self.view.frame.size.height - 64 - 90)];
    self.tabBar.itemTitleColor = [UIColor blackColor];
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
    lable.text = @"当前:中国山东省烟台市芝罘区祥尧街";
    lable.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:lable];
}

- (void)initViewControllers {
    AllFoodViewController *controller1 = [[AllFoodViewController alloc] init];
    controller1.yp_tabItemTitle = @"全部";
    controller1.cityStr = self.city;
    AroundFoodViewController *controller2 = [[AroundFoodViewController alloc] init];
    controller2.yp_tabItemTitle = @"附近";
    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
    
}

@end
