//
//  OrderViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@property (strong, nonatomic) ETShopHelper *helper;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configureUI];
    [self initViewControllers];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setTabBarFrame:CGRectMake(0, 0, screenSize.width, 44)
        contentViewFrame:CGRectMake(0, 44, kScreenWidth, self.view.frame.size.height - 64 - 44)];
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:15];
    
    [self.tabBar setScrollEnabledAndItemWidth:kScreenWidth/6];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
    self.tabBar.itemSelectedBgColor = [UIColor redColor];
    [self.tabBar setItemSelectedBgInsets:UIEdgeInsetsMake(42, 0, 0, 0) tapSwitchAnimated:NO];
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.str isEqualToString:@"1"]) {
        self.tabBar.selectedItemIndex = 1;
    }else if ([self.str isEqualToString:@"2"]){
        self.tabBar.selectedItemIndex = 2;
    }else if ([self.str isEqualToString:@"3"]){
        self.tabBar.selectedItemIndex = 3;
    }else if ([self.str isEqualToString:@"4"]){
        self.tabBar.selectedItemIndex = 4;
    }else if ([self.str isEqualToString:@"5"]){
        self.tabBar.selectedItemIndex = 5;
    }
    else{
        self.tabBar.selectedItemIndex = 0;
    }
}
- (void)configureUI{

}

- (void)initViewControllers {
    AllOrderViewController *controller1 = [[AllOrderViewController alloc] init];
    controller1.yp_tabItemTitle = @"全部";
    
    DaiPayViewController *controller2 = [[DaiPayViewController alloc] init];
    controller2.yp_tabItemTitle = @"待付款";
    
    DaiUserViewController *controller3 = [[DaiUserViewController alloc] init];
    controller3.yp_tabItemTitle = @"待使用";
    
    DaiSippingViewController *controller4 = [[DaiSippingViewController alloc] init];
    controller4.yp_tabItemTitle = @"待发货";
    
    DaiSureViewController *controller5 = [[DaiSureViewController alloc] init];
    controller5.yp_tabItemTitle = @"待确认";
    
    DaiValuationViewController *controller6 = [[DaiValuationViewController alloc] init];
    controller6.yp_tabItemTitle = @"待评价";    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, controller5, controller6, nil];
    
}

@end
