//
//  ETRigestController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETRigestController.h"
#import "ETTimeManager.h"
#import "ETWelcomeHelper.h"
#import "ConnectModel.h"

@interface ETRigestController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (weak, nonatomic) IBOutlet UITextField *codeNumber;
@property (weak, nonatomic) IBOutlet UITextField *inputPwdField;
@property (weak, nonatomic) IBOutlet UIButton *pwdSecretBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (copy, nonatomic) ETTimerHandle processHanle;
@property (copy, nonatomic) ETTimerHandle finishHanle;
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) ETWelcomeHelper *helper;
@property (copy, nonatomic) NSString *avatarStr;
@end
static NSString * Get_ID_Key = @"getregistid";
@implementation ETRigestController

-(ETWelcomeHelper *)helper{
    if (!_helper) {
        _helper = [ETWelcomeHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册账号";
    // Do any additional setup after loading the view from its nib.
    [self configureTimeInterval];
    [self configureUI];
}

- (void)configureUI{
    //layer
    _phoneNumber.layer.borderColor = [[UIColor whiteColor] CGColor];
    _phoneNumber.layer.borderWidth = 2;
    _codeNumber.layer.borderColor = [[UIColor whiteColor] CGColor];
    _codeNumber.layer.borderWidth = 2;
    _inputPwdField.layer.borderColor = [[UIColor whiteColor] CGColor];
    _inputPwdField.layer.borderWidth = 2;
    _avatarBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    _avatarBtn.layer.borderWidth = 3;
    _avatarBtn.layer.cornerRadius = 35;
    _avatarBtn.clipsToBounds = true;
    _registerBtn.layer.cornerRadius =6;
    _getCode.layer.cornerRadius = 2;
    //
    WEAKSELF
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        st_dispatch_async_main(^{
            [weakSelf takePhoto];
        });
    }]];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        st_dispatch_async_main(^{
            [weakSelf getLocationPhoto];
        });
    }]];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
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
            weakSelf.getCode.backgroundColor = [UIColor grayColor];
            NSString *buttonTitle = [NSString stringWithFormat:@"%ld秒后重新获取",(long)timeInterVal];
            [weakSelf.getCode setTitle:buttonTitle forState:UIControlStateNormal];
            weakSelf.getCode.userInteractionEnabled = false;
        });
    };
    self.finishHanle = ^(NSInteger timeInterVal){
        weakSelf.getCode.backgroundColor = ETColor;
        [weakSelf.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        weakSelf.getCode.userInteractionEnabled = true;
    };
    ETTimeTask *task = [ETTimeManager sharedETTimeManager].taskDic[Get_ID_Key];
    if (task) {
        [task setTaskWithOwner:self process:self.processHanle finish:self.finishHanle];
    }
}

- (void)takePhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:true completion:nil];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"相机不可用"];
}

- (void)getLocationPhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:true completion:nil];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"相册不可用"];
}

//获取验证码
- (IBAction)getCodeAction:(id)sender {
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
//    }];;
    [[ETTimeManager sharedETTimeManager] beginTimeTaskWithOwner:self Key:Get_ID_Key timeInterval:30 process:self.processHanle finish:self.finishHanle];
}

- (IBAction)pwdSecretAction:(UIButton *)sender {
    if (_inputPwdField.secureTextEntry) {
        _inputPwdField.secureTextEntry = false;
        [sender setImage:[UIImage imageNamed:@"ic_zhengyan"] forState:UIControlStateNormal];
    }else{
        _inputPwdField.secureTextEntry = true;
        [sender setImage:[UIImage imageNamed:@"ic_biyan"] forState:UIControlStateNormal];
    }
}

- (IBAction)avatarBtnClicked:(id)sender{
    [self presentViewController:self.alertController animated:true completion:nil];
}

- (IBAction)registerBtnClicked:(id)sender{
    if (_phoneNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (_codeNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (_inputPwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    WEAKSELF
    [_helper registerWithPhone:_phoneNumber.text password:_inputPwdField.text code:_codeNumber.text devicestate:@"1" success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            if ([[response valueForKey:@"status"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                [weakSelf.navigationController popViewControllerAnimated:true];
            }
        });
    } faild:^(NSString *response, NSError *error) {
        st_dispatch_async_main(^{
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        });
    }];
}

#pragma mark ----UIImagePickerControllerDelegate-----
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    if (![info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        return;
    }
    //裁剪后图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    //先压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image,0.3);
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    self.avatarStr = imageName;
    [ConnectModel uploadWithImageName:imageName imageData:imageData URL:nil finish:^(NSData *resultData) {
       st_dispatch_async_main(^{
           [SVProgressHUD showSuccessWithStatus:@"上传成功"];
       });
    }];
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark ----scrollDelegate-----
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    [self.view endEditing:true];
}
@end
