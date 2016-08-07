//
//  LocationViewController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "LocationViewController.h"
#import "SDCycleScrollView.h"
#import "ETLogInViewController.h"

@interface LocationViewController ()<SDCycleScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *headView;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = false;
    [self configureUI];
}

- (void)configureUI{
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn1 setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    self.navigationItem.rightBarButtonItem = item1;
    NSArray *imageNames = @[@"ic_lunbotu",
                            @"ic_lunbotu",
                            @"ic_lunbotu",
                            @"ic_lunbotu",
                            @"ic_lunbotu" // 本地图片请填写全名
                            ];
    // Do any additional setup after loading the view from its nib.
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, _headView.frame.size.height) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [_headView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;

}

- (void)rightNavBtnAction:(UIButton*)btn{
    ETLogInViewController * vc = [[ETLogInViewController alloc]initWithNibName:@"ETLogInViewController" bundle:nil];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

@end
