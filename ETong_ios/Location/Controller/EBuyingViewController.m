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
#import "CZCountDownView.h"

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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, Screen_frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithRed:253/255.0 green:74/255.0 blue:75/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(0, 0, 100, 44);
    lable.text = @"距结束仅剩";
    lable.textAlignment = NSTextAlignmentRight;
    lable.textColor = [UIColor whiteColor];
    [view addSubview:lable];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger time = round(interval);
    
    // 封装后
    CZCountDownView *countDown = [CZCountDownView countDown];
    countDown.frame = CGRectMake(110, 0, Screen_frame.size.width - 120, 44);
    countDown.timestamp = (1478833871 - time);
    countDown.timerStopBlock = ^{
        NSLog(@"时间停止");
    };
    [view addSubview:countDown];
    
    CZCountDownView *c1 = [CZCountDownView countDown];
    CZCountDownView *c2 = [CZCountDownView countDown];
    NSLog(@"%p--%p",c1,c2);

}

- (void)initViewControllers {
    AllEBuyingViewController *controller1 = [[AllEBuyingViewController alloc] init];
    controller1.yp_tabItemTitle = @"全城";
    
    DistanceAllBuyingViewController *controller2 = [[DistanceAllBuyingViewController alloc] init];
    controller2.yp_tabItemTitle = @"距离";
    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
    
}


@end
