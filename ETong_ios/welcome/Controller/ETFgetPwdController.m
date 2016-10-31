//
//  ETFgetPwdController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETFgetPwdController.h"
#import "ETTimeManager.h"
#import "ETWelcomeHelper.h"

@interface ETFgetPwdController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputCode;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdField;
@property (weak, nonatomic) IBOutlet UIButton *pwdEyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (copy, nonatomic) ETTimerHandle processHanle;
@property (copy, nonatomic) ETTimerHandle finishHanle;
@property (strong, nonatomic) ETWelcomeHelper *helper;
@end

static NSString * Get_ID_Key = @"getcodeid";

@implementation ETFgetPwdController

-(ETWelcomeHelper *)helper{
    if (!_helper) {
        _helper = [ETWelcomeHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    // Do any additional setup after loading the view from its nib.
//    [self configureTimeInterval];
    [self configureUI];
}
- (void)configureTimeInterval{
    WEAKSELF
    [weakSelf.helper sendMobileCodeWithPhone:weakSelf.phoneNumber.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
            
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
    self.processHanle = ^(NSInteger timeInterVal){
        st_dispatch_async_main(^{
            weakSelf.getCodeBtn.backgroundColor = [UIColor grayColor];
            NSString *buttonTitle = [NSString stringWithFormat:@"%ld秒后重新获取",(long)timeInterVal];
            [weakSelf.getCodeBtn setTitle:buttonTitle forState:UIControlStateNormal];
            weakSelf.getCodeBtn.userInteractionEnabled = false;
        });
    };
    self.finishHanle = ^(NSInteger timeInterVal){
        weakSelf.getCodeBtn.backgroundColor = ETColor;
        [weakSelf.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        weakSelf.getCodeBtn.userInteractionEnabled = true;
    };
    ETTimeTask *task = [ETTimeManager sharedETTimeManager].taskDic[Get_ID_Key];
    if (task) {
        [task setTaskWithOwner:self process:self.processHanle finish:self.finishHanle];
    }
}
- (void)configureUI{
    //layer
    _phoneNumber.layer.borderColor = [[UIColor whiteColor] CGColor];
    _phoneNumber.layer.borderWidth = 2;
    _inputCode.layer.borderColor = [[UIColor whiteColor] CGColor];
    _inputCode.layer.borderWidth = 2;
    _passwordField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _passwordField.layer.borderWidth = 2;
    _comfirmPwdField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _comfirmPwdField.layer.borderWidth = 2;
    _completeBtn.layer.cornerRadius = 6;
    _getCodeBtn.layer.cornerRadius = 2;
}

- (IBAction)pwdSecretAction:(UIButton *)sender {
    if (_passwordField.secureTextEntry) {
        _passwordField.secureTextEntry = false;
        [sender setImage:[UIImage imageNamed:@"ic_zhengyan"] forState:UIControlStateNormal];
    }else{
        _passwordField.secureTextEntry = true;
        [sender setImage:[UIImage imageNamed:@"ic_biyan"] forState:UIControlStateNormal];
    }
}
- (IBAction)confirmPwdAction:(UIButton *)sender {
    if (_comfirmPwdField.secureTextEntry) {
        _comfirmPwdField.secureTextEntry = false;
        [sender setImage:[UIImage imageNamed:@"ic_zhengyan"] forState:UIControlStateNormal];
    }else{
        _comfirmPwdField.secureTextEntry = true;
        [sender setImage:[UIImage imageNamed:@"ic_biyan"] forState:UIControlStateNormal];
    }
}
- (IBAction)getCode:(id)sender {
    if (_phoneNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
//    [_helper sendMobileCodeWithPhone:_phoneNumber.text success:^(NSDictionary *response) {
//        st_dispatch_async_main(^{
//            [SVProgressHUD showSuccessWithStatus:@"成功"];
//            
//        });
//    } faild:^(NSString *response, NSError *error) {
//        [SVProgressHUD showSuccessWithStatus:@"失败"];
//    }];
    [self configureTimeInterval];
    [[ETTimeManager sharedETTimeManager] beginTimeTaskWithOwner:self Key:Get_ID_Key timeInterval:30 process:self.processHanle finish:self.finishHanle];
}

- (IBAction)completeBtn:(id)sender {
    if (_phoneNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (_inputCode.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (_passwordField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (_comfirmPwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请确认密码"];
        return;
    }
    if (![_passwordField.text isEqualToString:_comfirmPwdField.text]){
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        return;
    }
    [_helper changePasswordWithPhone:_phoneNumber.text code:_inputCode.text password:_passwordField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:true];
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"修改失败"];
    }];
}
#pragma mark ----scrollDelegate-----
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    [self.view endEditing:true];
}
@end
