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
#import "SelectCityViewController.h"
#import "FoodViewController.h"
#import "HotelViewController.h"
#import "MovieViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController ()<SDCycleScrollViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) NSString *str;
@property (weak, nonatomic) IBOutlet UIImageView *foodBtn;
@property (strong, nonatomic)  CLLocationManager *locationManager;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = false;
    self.str = @"北京";
    [self configureUI];
    _locationManager = [[CLLocationManager alloc] init];
    //期望的经度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //大约变化100米更新一次
    _locationManager.distanceFilter = 100;
    //认证NSLocationAlwaysUsageDescription
    if ([[UIDevice currentDevice] systemVersion].doubleValue > 8.0) {//如果iOS是8.0以上版本
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {//位置管理对象中有requestAlwaysAuthorization这个方法
            //运行
            [_locationManager requestAlwaysAuthorization];
        }
    }
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];;//取出最后一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //反向地理编码
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSLog(@"所在城市====%@ %@ %@ %@", state, city, subLocality, street);
            //如果不需要实时定位，使用完即使关闭定位服务。
            [_locationManager stopUpdatingLocation];
        }
    }];
    
}

- (void)configureUI{
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn1 setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    self.navigationItem.rightBarButtonItem = item1;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 100, 30);
    [self.leftBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    // button标题居左显示
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
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

-(void)leftNavBtnAction:(UIButton *)btn{
    SelectCityViewController *vc = [[SelectCityViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)passTrendValues:(NSString *)city{
    [self.leftBtn setTitle:self.str forState:UIControlStateNormal];
    NSLog(@"%@", city);
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}
#pragma mark - 美食
- (IBAction)ClickFoodBtn:(id)sender {
    FoodViewController *vc = [[FoodViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 电影
- (IBAction)ClickMovieBtn:(id)sender {
    MovieViewController *vc = [[MovieViewController alloc] init];
    vc.title = @"电影";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 酒店
- (IBAction)ClickHotelBtn:(id)sender {
    HotelViewController *vc = [[HotelViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.title = @"酒店";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
