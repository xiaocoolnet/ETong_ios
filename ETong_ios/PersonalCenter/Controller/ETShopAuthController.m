//
//  ETShopAuthController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETShopAuthController.h"
#import "ETShopInfoController.h"
#import "ConnectModel.h"
#import "ETShopHelper.h"

@interface ETShopAuthController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *legalPersonName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *idcardNumber;
@property (weak, nonatomic) IBOutlet UITextField *registerNumber;
@property (weak, nonatomic) IBOutlet UITextField *businessAddress;
@property (weak, nonatomic) IBOutlet UIButton *handleIDCard;
@property (weak, nonatomic) IBOutlet UIButton *idCardPhoto;
@property (weak, nonatomic) IBOutlet UIButton *businessLicense;//营业执照
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) NSString *firstPhotoName;
@property (strong, nonatomic) NSString *secondPhotoName;
@property (strong, nonatomic) NSString *thirdPhotoName;
@property (strong, nonatomic) ETShopHelper *helper;

@end

@implementation ETShopAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    
    self.title = @"店铺认证";
}

- (void)configureUI{
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

- (IBAction)configurePhoto:(UIButton *)sender {
    self.selectBtn = sender;
    [self presentViewController:self.alertController animated:true completion:nil];
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

- (IBAction)nextStep:(id)sender{
    if (_legalPersonName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入法人姓名"];
        return;
    }
    if (_phoneNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入法人手机号码"];
        return;
    }
    if (_idcardNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    if (_registerNumber.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入工商注册号"];
        return;
    }
    if (_businessAddress.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入经营地址"];
        return;
    }
    if (_firstPhotoName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传手持身份证照"];
        return;
    }
    if (_secondPhotoName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证正面照"];
        return;
    }
    if (_thirdPhotoName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传营业执照"];
        return;
    }
    
    [_helper upDataCreatShopInfoWithUserid:[ETUserInfo sharedETUserInfo].id city:@"" shopName:@"" legalperson:_legalPersonName.text phone:_phoneNumber.text type:@"" businesslicense:_registerNumber.text address:_businessAddress.text idcard:_idcardNumber.text positive_pic:_firstPhotoName opposite_pic:_secondPhotoName license_pic:_thirdPhotoName success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"提交信息成功"];
        });
    } faild:^(NSString *response, NSError *error) {
        
    }];
    
    ETShopInfoController *vc =[[ETShopInfoController alloc] initWithNibName:@"ETShopInfoController" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark ----UIImagePickerControllerDelegate-----
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    
    if (![info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        return;
    }
    //裁剪后图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.selectBtn setImage:image forState:UIControlStateNormal];
    //先压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image,0.3);
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    
    [ConnectModel uploadWithImageName:imageName imageData:imageData URL:nil finish:^(NSData *resultData) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        });
    }];
    imageName = [imageName stringByAppendingString:@".png"];
    
    if (_selectBtn.tag == 11) {
        _firstPhotoName = imageName;
    }else if (_selectBtn.tag == 22){
        _secondPhotoName = imageName;
    }else if (_selectBtn.tag == 33){
        _thirdPhotoName = imageName;
    }
    
    [picker dismissViewControllerAnimated:true completion:nil];
}
@end