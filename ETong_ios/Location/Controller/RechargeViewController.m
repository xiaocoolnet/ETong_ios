//
//  RechargeViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UIView *flowView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self configureUI];
    [self initViewControllers];
    [self addSureBtn];
}
- (void)configureUI{
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"请输入手机号";
    self.textField.frame = CGRectMake(5, 0, Screen_frame.size.width - 10, 50);
    [self.view addSubview:self.textField];
    self.textField.backgroundColor = [UIColor whiteColor];
}

- (void)initViewControllers {
    
    self.leftBtn = [[UIButton alloc] init];
    _leftBtn.frame = CGRectMake(0, 60, Screen_frame.size.width/2.0, 50);
    _leftBtn.backgroundColor = [UIColor whiteColor];
    [_leftBtn setTitle:@"充话费" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn];
    
    self.rightBtn = [[UIButton alloc] init];
    self.rightBtn.frame = CGRectMake(Screen_frame.size.width/2.0, 60, Screen_frame.size.width/2.0, 50);
    self.rightBtn.backgroundColor = [UIColor whiteColor];
    [self.rightBtn setTitle:@"充流量" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightBtn];
    
    [self addPhoneView];
    
}

-(void)clickBtn1{
    [self.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.phoneView removeFromSuperview];
    [self.flowView removeFromSuperview];
    [self addPhoneView];
}

-(void)clickBtn2{
    [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.phoneView removeFromSuperview];
    [self addFlowView];
}

-(void) addPhoneView{
    self.phoneView = [[UIView alloc] init];
    self.phoneView.frame = CGRectMake(0, 120, Screen_frame.size.width, 200);
    self.phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneView];
    [self addBtn];
}

-(void) addFlowView{
    self.flowView = [[UIView alloc] init];
    self.flowView.frame = CGRectMake(0, 120, Screen_frame.size.width, 200);
    self.flowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.flowView];
    [self addFlowBtn];
}

-(void) addBtn{
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(10, 10, Screen_frame.size.width - 20, 40);
    name.text = @"优惠券";
    name.textColor = [UIColor lightGrayColor];
    name.font = [UIFont systemFontOfSize:15];
    [self.phoneView addSubview:name];
        self.array = @[@"30元",@"50元",@"100元"];
        self.arr = @[@"200元",@"300元",@"400元"];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(12 + (Screen_frame.size.width - 20)/3.0 * i, 60, (Screen_frame.size.width - 40)/3.0, 60);
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setTitle:self.array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [self.phoneView addSubview:btn];
    }
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(12 + (Screen_frame.size.width - 20)/3.0 * i, 130, (Screen_frame.size.width - 40)/3.0, 60);
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setTitle:self.arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1003 + i;
        [self.phoneView addSubview:btn];
    }
}

-(void)addFlowBtn{
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(10, 10, Screen_frame.size.width - 20, 40);
    name.text = @"优惠券";
    name.textColor = [UIColor lightGrayColor];
    name.font = [UIFont systemFontOfSize:15];
    [self.flowView addSubview:name];

        self.array = @[@"30M",@"50M",@"100M"];
        self.arr = @[@"200M",@"300M",@"400M"];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(12 + (Screen_frame.size.width - 20)/3.0 * i, 60, (Screen_frame.size.width - 40)/3.0, 60);
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setTitle:self.array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [self.flowView addSubview:btn];
    }
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(12 + (Screen_frame.size.width - 20)/3.0 * i, 130, (Screen_frame.size.width - 40)/3.0, 60);
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setTitle:self.arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1003 + i;
        [self.flowView addSubview:btn];
    }
}

-(void) addSureBtn{
    UIButton *sureBtn = [[UIButton alloc] init];
    sureBtn.frame = CGRectMake(10, 400, Screen_frame.size.width - 20, 40);
    sureBtn.backgroundColor= [UIColor redColor];
    sureBtn.layer.cornerRadius = 8;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
}

-(void)clickBtn:(UIButton *)sender{
    for (int i=0; i < 8; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        if (sender.tag - 1000 == i) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor redColor].CGColor;
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            
        }
    }
}


@end
