//
//  PersonViewController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "PersonViewController.h"
#import "UIButton+WebCache.h"
#import "ETShopBeginAuthVC.h"
#import "ETShopHelper.h"
#import "ETShopModel.h"
#import "OrderViewController.h"
#import "CollectViewController.h"
#import "EvaluateViewController.h"
#import "NewsViewController.h"
#import "FootprintsViewController.h"

@interface PersonViewController ()

@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hgImageView;
@property (weak, nonatomic) IBOutlet UIButton *egouBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *youhuiBtn;
@property (weak, nonatomic) IBOutlet UIButton *daiFKbtn;
@property (weak, nonatomic) IBOutlet UIButton *daiSYBtn;
@property (weak, nonatomic) IBOutlet UIButton *daiFHBtn;
@property (weak, nonatomic) IBOutlet UIButton *daiSHbtn;
@property (weak, nonatomic) IBOutlet UIButton *daiPJBtn;
@property (strong, nonatomic) ETShopHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) OrderViewController *vc;

@end

@implementation PersonViewController

-(ETShopHelper *)helper{
    if (!_helper) {
        _helper = [ETShopHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI{
    _avatarBtn.layer.cornerRadius = 40;
    _avatarBtn.clipsToBounds = true;
    
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn1 setImage:[UIImage imageNamed:@"ic_xiaoxi"] forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn2 setImage:[UIImage imageNamed:@"ic_shezhi"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"ic_saoyisao"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    self.navigationItem.leftBarButtonItem = item3;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //
    [self configureUser];
}

- (void)configureUser{
    if ([ETUserInfo sharedETUserInfo].isLogin) {
        WEAKSELF
        [self.helper updataUserInfo:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,[ETUserInfo sharedETUserInfo].photo];
                [weakSelf.avatarBtn sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_touxiang"]];
                weakSelf.nameLabel.text = [ETUserInfo sharedETUserInfo].name;
            });
        }];
    }
}

- (void)rightNavBtnAction:(UIButton*)btn{
}
- (void)leftNavBtnAction:(UIButton*)btn{
}
- (IBAction)footerClicked:(id)sender {
}
- (IBAction)weiquanClicked:(id)sender {
}
- (IBAction)edailiClicked:(id)sender {
}
- (IBAction)pingjiaClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    WEAKSELF
    [self.helper getMyShopInfoWithUserid:[ETUserInfo sharedETUserInfo].id success:^(NSDictionary *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            EvaluateViewController *vc = [[EvaluateViewController alloc] init];
            vc.title = @"评价";
            vc.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:vc animated:true];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}
- (IBAction)fenxiangClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    WEAKSELF
    [self.helper getMyShopInfoWithUserid:[ETUserInfo sharedETUserInfo].id success:^(NSDictionary *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            NewsViewController *vc = [[NewsViewController alloc] init];
            vc.title = @"消息列表";
            vc.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:vc animated:true];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

//我要开店
- (IBAction)kaidianClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    WEAKSELF
    [self.helper getMyShopInfoWithUserid:[ETUserInfo sharedETUserInfo].id success:^(NSDictionary *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            ETShopModel *model = [ETShopModel mj_objectWithKeyValues:response];
            ETMyShopController *vc = [[ETMyShopController alloc] initWithNibName:@"ETMyShopController" bundle:nil];
            vc.model = model;
            vc.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:vc animated:true];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
//    ETShopBeginAuthVC *vc = [[ETShopBeginAuthVC alloc]initWithNibName:@"ETShopBeginAuthVC" bundle:nil];
//    [self.navigationController pushViewController:vc animated:true];
}
- (IBAction)zujiClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    FootprintsViewController *vc = [[FootprintsViewController alloc] init];
    vc.title = @"我的足迹";
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)vipCenterClicked:(id)sender {
}
- (IBAction)qianbaoClicked:(id)sender {
}
- (IBAction)daiPJClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    self.vc = [[OrderViewController alloc] init];
    self.vc.str = @"5";
    [self getData];
}
- (IBAction)daiSHClicked:(id)sender {
    self.vc = [[OrderViewController alloc] init];
    self.vc.str = @"4";
    [self getData];
}
- (IBAction)darFHClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    self.vc = [[OrderViewController alloc] init];
    self.vc.str = @"3";
    [self getData];
}
- (IBAction)daiSYCilcked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    self.vc = [[OrderViewController alloc] init];
    self.vc.str = @"2";
    [self getData];
}
- (IBAction)daiFKClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    self.vc = [[OrderViewController alloc] init];
    self.vc.str = @"1";
    [self getData];
    
}
- (IBAction)allOrderClicked:(id)sender {
    self.vc = [[OrderViewController alloc] init];
    [self getData];
}
- (IBAction)youhuiBtnClicked:(id)sender {
}
- (IBAction)shoucangBtnClicked:(id)sender {
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    WEAKSELF
    [self.helper getMyShopInfoWithUserid:[ETUserInfo sharedETUserInfo].id success:^(NSDictionary *response) {
        NSLog(@"%@",[ETUserInfo sharedETUserInfo].id);
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
           
            CollectViewController *vc = [[CollectViewController alloc] init];
            vc.title = @"收藏";
            vc.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:vc animated:true];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
    
}
- (IBAction)egouBtnClicked:(id)sender {
}
- (IBAction)avatarClicked:(id)sender {
    ETCUserInfoController *vc =[[ETCUserInfoController alloc] initWithNibName:@"ETCUserInfoController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)getData{
//    OrderViewController *vc = [[OrderViewController alloc] init];
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    WEAKSELF
    [self.helper getMyShopInfoWithUserid:[ETUserInfo sharedETUserInfo].id success:^(NSDictionary *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{            
            self.vc.title = @"订单管理";
            self.vc.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:self.vc animated:true];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];

}

@end
