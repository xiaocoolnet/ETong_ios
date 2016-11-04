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
#import "AroundTravelViewController.h"
#import "LifeViewController.h"
#import "RechargeViewController.h"
#import "ALLViewController.h"
#import "KTVViewController.h"
#import "TakeOutViewController.h"
#import "ETLocationLikeCell.h"
#import "EveryDayHelper.h"
#import "RecreationViewController.h"
#import "EBuyingViewController.h"
#import "NowDayViewController.h"
#import "NewPeopleViewController.h"
#import "AllItemizeViewController.h"

@interface LocationViewController ()<SDCycleScrollViewDelegate, CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) NSString *str;
@property (weak, nonatomic) IBOutlet UIImageView *foodBtn;
@property (strong, nonatomic)  CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITableView *likeTableView;
@property (strong, nonatomic) NSMutableArray *likeArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightLayout;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (nonatomic, copy) NSString *cityStr;

@end

@implementation LocationViewController
-(NSMutableArray *)likeArray{
    if (_likeArray == nil) {
        return [NSMutableArray array];
    }
    return _likeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = false;
    self.cityStr = @"烟台市";
    [self configureUI];
    [_likeTableView registerNib:[UINib nibWithNibName:@"ETLocationLikeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _likeTableView.scrollEnabled = false;
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
-(void)viewWillAppear:(BOOL)animated{
    [self getData];
}
- (void)viewDidAppear:(BOOL)animated{
    
}

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
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

-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error{
    NSLog(@"hahahahahh = %@",error);
}

#pragma mark - 获取猜你喜欢
-(void)getData{
    WEAKSELF
    [self.helper getGoodShopInfoWithIsLike:nil success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            weakSelf.likeArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                [weakSelf.likeArray addObject:model];
            }
            [weakSelf.likeTableView reloadData];
            _contentHeightLayout.constant = 486 + _likeTableView.contentSize.height;
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
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
    [self.leftBtn setTitle:self.cityStr forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    // button标题居左显示
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
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
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        ETLogInViewController * vc = [[ETLogInViewController alloc]initWithNibName:@"ETLogInViewController" bundle:nil];
        vc.hidesBottomBarWhenPushed = true;
        vc.type = @"login";
        [self.navigationController pushViewController:vc animated:true];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"您已登录"];
}

-(void)leftNavBtnAction:(UIButton *)btn{
    SelectCityViewController *vc = [[SelectCityViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)passTrendValues:(NSString *)city{
    [self.leftBtn setTitle:city forState:UIControlStateNormal];
//    self.cityStr = [[NSString alloc] init];
    self.cityStr = city;
    NSLog(@"%@", self.cityStr);
}

#pragma mark - UITableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return self.likeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    ETLocationLikeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ETGoodsDataModel *model = self.likeArray[indexPath.row];
    cell.goodsNameLabel.text = model.goodsname;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIMAGE_URL_HEAD,[[model.picture componentsSeparatedByString:@","] firstObject]]];
    [cell.avatarImage sd_setImageWithURL:url];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    cell.descript.text = model.description;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETGoodsDetailController *controller = [[ETGoodsDetailController alloc]init];
    ETGoodsDataModel *model = self.likeArray[indexPath.row];
    controller.goodsid = model.id;
    controller.shopid = model.shopid;
    controller.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:controller animated:true];
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
    vc.city = self.cityStr;
    NSLog(@"dddd = %@",self.cityStr);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 电影
- (IBAction)ClickMovieBtn:(id)sender {
    MovieViewController *vc = [[MovieViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.title = @"电影";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 周边游
- (IBAction)ClickTravelBtn:(id)sender {
    AroundTravelViewController *vc = [[AroundTravelViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.title = @"周边游";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 酒店
- (IBAction)ClickHotelBtn:(id)sender {
    HotelViewController *vc = [[HotelViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.title = @"酒店";
    vc.city = self.cityStr;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 生活服务
- (IBAction)ClickLifeBtn:(id)sender {
    LifeViewController *vc = [[LifeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.title = @"生活服务";
    vc.city = self.cityStr;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - 手机充值
- (IBAction)ClickRechargeBtn:(id)sender {
    RechargeViewController *vc = [[RechargeViewController alloc] init];
    vc.title = @"手机充值";
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - 全部
- (IBAction)ClickAllBtn:(id)sender {
    AllItemizeViewController *vc = [[AllItemizeViewController alloc] init];
    vc.title = @"全部";
    vc.cityStr = self.cityStr;
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - 外卖
- (IBAction)ClickTakeOutBtn:(id)sender {
    TakeOutViewController *vc = [[TakeOutViewController alloc] init];
    vc.title = @"外卖";
    vc.hidesBottomBarWhenPushed = true;
    vc.city = self.cityStr;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 休闲娱乐
- (IBAction)RecreationBtn:(id)sender {
    RecreationViewController *vc = [[RecreationViewController alloc] init];
    vc.title = @"休闲娱乐";
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - KTV
- (IBAction)ClickKTVBtn:(id)sender {
    KTVViewController *vc = [[KTVViewController alloc] init];
    vc.title = @"KTV";
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - e抢购
- (IBAction)EBuyingBtn:(id)sender {
    EBuyingViewController *vc = [[EBuyingViewController alloc] init];
    vc.title = @"e抢购";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 今日特价
- (IBAction)NowDayBtn:(id)sender {
    NowDayViewController *vc = [[NowDayViewController alloc] init];
    vc.title = @"今日特价";
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 今日专享
- (IBAction)OneMoneyBtn:(id)sender {
    NewPeopleViewController *vc = [[NewPeopleViewController alloc] init];
    vc.title = @"新客专享";
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
