//
//  EZoneViewController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "EZoneViewController.h"
#import "ETMyZoneController.h"
#import "ETSidelineZoneController.h"

@interface EZoneViewController ()

@end

@implementation EZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 44, kScreenWidth, self.view.frame.size.height - 64 - 50)];
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
    ETMyZoneController *controller1 = [[ETMyZoneController alloc] initWithNibName:@"ETMyZoneController" bundle:nil];
    controller1.yp_tabItemTitle = @"我的专区";
    
    ETSidelineZoneController *controller2 = [[ETSidelineZoneController alloc] initWithNibName:@"ETSidelineZoneController" bundle:nil];
    controller2.yp_tabItemTitle = @"农副产品专区";

    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
    
}

@end
