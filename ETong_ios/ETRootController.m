//
//  ETRootController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETRootController.h"
#import "PersonViewController.h"
#import "EZoneViewController.h"
#import "LocationViewController.h"
#import "HomePageController.h"

@interface ETRootController ()

@property(nonatomic,strong) PersonViewController *person;
@property(nonatomic,strong) JSCartViewController *shopCart;
@property(nonatomic,strong) EZoneViewController *eZone;
@property(nonatomic,strong) LocationViewController *location;
@property(nonatomic,strong) HomePageController *home;

@end

@implementation ETRootController

-(PersonViewController *)person{
    if (!_person) {
        _person = [[PersonViewController alloc]initWithNibName:@"PersonViewController" bundle:nil];
        _person.title = @"我的";
    }
    return _person;
}

-(JSCartViewController *)shopCart{
    if (!_shopCart) {
        _shopCart = [[JSCartViewController alloc]init];
        _shopCart.title = @"购物车";
    }
    return _shopCart;
}

-(EZoneViewController *)eZone{
    if (!_eZone) {
        _eZone = [[EZoneViewController alloc]init];
        _eZone.title = @"e专区";
    }
    return _eZone;
}

-(LocationViewController *)location{
    if (!_location) {
        _location = [[LocationViewController alloc]initWithNibName:@"LocationViewController" bundle:nil];
        _location.title = @"本地";
    }
    return _location;
}

-(HomePageController *)home{
    if (!_home) {
        _home = [[HomePageController alloc]initWithNibName:@"HomePageController" bundle:nil];
        _home.title = @"首页";
    }
    return _home;
}

//设置tabbarItem样式
- (UINavigationController *)setTabBarItemWithController:(UIViewController *)controller normalImageName:(NSString *)normalName SelectName:(NSString *)selectName{
    
    UINavigationController *aNav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    controller.tabBarItem.image = [[UIImage imageNamed:normalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ETColor} forState:UIControlStateSelected];
    
    return aNav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *homeNav = [self setTabBarItemWithController:self.home normalImageName:@"ic_shouye_hui" SelectName:@"ic_shouye_red"];
    
    UINavigationController *locNav = [self setTabBarItemWithController:self.location normalImageName:@"ic_bendi_hui" SelectName:@"ic_bendi_red"];
    
    UINavigationController *eZoneNav = [self setTabBarItemWithController:self.eZone normalImageName:@"ic_ezhuanqu_hui" SelectName:@"ic_ezhuanqu_red"];
    
    UINavigationController *shopNav = [self setTabBarItemWithController:self.shopCart normalImageName:@"ic_gouwuche_hui" SelectName:@"ic_gouwuche_red"];
    
    UINavigationController *personNav = [self setTabBarItemWithController:self.person normalImageName:@"ic_wode_hui" SelectName:@"ic_wode_red"];
    
    self.viewControllers = @[homeNav,locNav,eZoneNav,shopNav,personNav];
}

@end
