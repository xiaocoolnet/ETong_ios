//
//  SelectCityViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SelectCityViewController.h"
#import "LocationViewController.h"
#import "JSAddressPickerView.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface SelectCityViewController ()<JSAddressPickerDelegate>
@property (nonatomic, strong) JSAddressPickerView *pickerView;
@property (nonatomic, strong) UIButton *button;
@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"城市选择";
    [self enterAddress];
}

- (void)enterAddress {
    if (self.pickerView) {
        self.pickerView.hidden = NO;
        return;
    }
    self.pickerView = [[JSAddressPickerView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    [self.pickerView updateAddressAtProvince:@"北京市" city:@"北京市"];
    self.pickerView.delegate = self;
    self.pickerView.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:self.pickerView];
}

- (void)JSAddressCancleAction:(id)senter {
    self.pickerView.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)JSAddressPickerRerurnBlockWithProvince:(NSString *)province city:(NSString *)city {
    self.pickerView.hidden = NO;
    NSLog(@"%@  %@",province,city);
    LocationViewController *vc = [[LocationViewController alloc] init];
    self.delegate = vc;
    [self.delegate passTrendValues:city];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setPickerView:(JSAddressPickerView *)pickerView {
    if (!_pickerView) {
        
    }
    _pickerView = pickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
