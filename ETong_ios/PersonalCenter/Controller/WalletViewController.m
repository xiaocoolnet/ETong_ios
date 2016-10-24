//
//  WalletViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "WalletViewController.h"

@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self addHeaderView];
    [self addView];
}

-(void)addHeaderView{
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 200)];
    aview.backgroundColor = [UIColor colorWithRed:253/255.0 green:74/255.0 blue:75/255.0 alpha:1.0];
    [self.view addSubview:aview];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2 - 40, 10, 80, 80)];
//    imgView.image = [UIImage imageNamed:@"ic_xihuan"];
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,[ETUserInfo sharedETUserInfo].photo];
    [imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    imgView.layer.cornerRadius = 40;
    imgView.layer.masksToBounds = YES;
    [aview addSubview:imgView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, Screen_frame.size.width, 30)];
    nameLab.font = [UIFont systemFontOfSize:18];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [aview addSubview:nameLab];
    nameLab.text = [ETUserInfo sharedETUserInfo].name;

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, Screen_frame.size.width/2 - 20, 30)];
    [btn setImage:[UIImage imageNamed:@"ic_yue"] forState:UIControlStateNormal];
    [btn setTitle:@"  余额500元" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [aview addSubview:btn];
    
    UIButton *couponsBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2 + 10, 160, Screen_frame.size.width/2 - 20, 30)];
    [couponsBtn setImage:[UIImage imageNamed:@"ic_ka_1"] forState:UIControlStateNormal];
    [couponsBtn setTitle:@"  优惠券0张" forState:UIControlStateNormal];
    couponsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [aview addSubview:couponsBtn];
}

-(void)addView{

    NSArray *imgArr = @[@"ic_youhuiquan_hong",@"ic_yongjin",@"ic_more_hong"];
    NSArray *labArr = @[@"优惠券",@"现金红包",@"敬请期待"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_frame.size.width/3 *i, 210, Screen_frame.size.width/3, 100)];
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width/2-20, 20, 40, 30)];
        img.image = [UIImage imageNamed:imgArr[i]];
        [btn addSubview:img];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, btn.frame.size.width, 30)];
        lable.font = [UIFont systemFontOfSize:15];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = labArr[i];
        [btn addSubview:lable];
    }
}


@end
