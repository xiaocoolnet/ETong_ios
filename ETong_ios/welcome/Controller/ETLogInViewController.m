//
//  ETLogInViewController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETLogInViewController.h"
#import "ETFgetPwdController.h"
#import "ETRigestController.h"
#import "ETWelcomeHelper.h"
#import "UMSocial.h"

@interface ETLogInViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *pwdNumber;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) ETWelcomeHelper *helper;
@end

@implementation ETLogInViewController

-(ETWelcomeHelper *)helper{
    if (!_helper) {
        _helper = [ETWelcomeHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    [self configureUI];
    [self autoLogin];
    
}

- (void)configureUI{
    //layer
    _phoneNumber.layer.borderColor = [[UIColor whiteColor] CGColor];
    _phoneNumber.layer.borderWidth = 2;
    _pwdNumber.layer.borderColor = [[UIColor whiteColor] CGColor];
    _pwdNumber.layer.borderWidth = 2;
    _loginBtn.layer.cornerRadius = 6;
}

- (void)autoLogin{
    NSDictionary *logInfo = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINFO_KEY];
    if (logInfo) {
        _phoneNumber.text = logInfo[USER_NAME];
        _pwdNumber.text = logInfo[USER_PWD];
        [self loginAction];
    }
}

- (IBAction)loginBtnAction:(id)sender {
    if (_phoneNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (_pwdNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    [self loginAction];
}

- (void)loginAction{
    [SVProgressHUD show];
    [self.helper loginWithPhoneNumber:_phoneNumber.text PassWord:_pwdNumber.text success:^(NSObject *response) {
        st_dispatch_async_main(^{
            if ([[response valueForKey:@"status"] isEqualToString:@"error"]) {
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
                return;
            }
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [[NSUserDefaults standardUserDefaults] setObject:@{USER_NAME:_phoneNumber.text,USER_PWD:_pwdNumber.text} forKey:LOGINFO_KEY];
            [self.navigationController popViewControllerAnimated:true];
        });
    } faild:^(NSString *response, NSError *error) {
    }];
}

- (IBAction)forgetPwd:(id)sender {
    ETFgetPwdController *vc = [[ETFgetPwdController alloc]initWithNibName:@"ETFgetPwdController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)registerImmediately:(id)sender {
    ETRigestController *rigester = [[ETRigestController alloc]initWithNibName:@"ETRigestController" bundle:nil];
    [self.navigationController pushViewController:rigester animated:true];
}

- (IBAction)loginWithWX:(id)sender {
}

- (IBAction)loginWithQQ:(id)sender {
}

- (IBAction)loginWithWB:(id)sender {
}

#pragma mark ----scrollDelegate-----
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    [self.view endEditing:true];
}

@end
