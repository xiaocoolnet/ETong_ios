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
#import "PersonViewController.h"
#import "YLDropDownMenu.h"
#import "AddressView.h"

@interface ETShopAuthController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate,AddressPickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *yingLab;
@property (weak, nonatomic) IBOutlet UITextField *legalPersonName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *idcardNumber;
@property (weak, nonatomic) IBOutlet UITextField *registerNumber;
@property (weak, nonatomic) IBOutlet UITextField *businessAddress;
@property (weak, nonatomic) IBOutlet UIButton *handleIDCard;
@property (weak, nonatomic) IBOutlet UITextField *permitName;
@property (weak, nonatomic) IBOutlet UIButton *idCardPhoto;
@property (weak, nonatomic) IBOutlet UIButton *businessLicense;//营业执照
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) NSString *firstPhotoName;
@property (strong, nonatomic) NSString *secondPhotoName;
@property (strong, nonatomic) NSString *thirdPhotoName;
@property (strong, nonatomic) ETShopHelper *helper;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopTypeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *comImg;
@property (weak, nonatomic) IBOutlet UIImageView *perImg;
@property (weak, nonatomic) IBOutlet UIImageView *yesImg;
@property (weak, nonatomic) IBOutlet UIImageView *noImg;
@property (nonatomic,strong) NSString *islocal;
@property (nonatomic, strong) NSString *provinceStr;
@property (nonatomic, strong) NSString *cityStr;
@property (nonatomic, strong) NSString *typeStr;


@property (nonatomic, strong)YLDropDownMenu *menuView;
@property (nonatomic, strong)UIView *darkView;
@property (nonatomic, strong) AddressView *pickerView;

@end

@implementation ETShopAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    
    self.title = @"店铺认证";
    
    self.legalPersonName.delegate = self;
    self.phoneNumber.delegate = self;
    self.idcardNumber.delegate = self;
    self.registerNumber.delegate = self;
    self.businessAddress.delegate = self;
    self.permitName.delegate = self;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture)];
    singleTap.numberOfTapsRequired = 1;
    [self.darkView addGestureRecognizer:singleTap];
    
}
- (IBAction)clickComButton:(id)sender {
    self.comImg.image = [UIImage imageNamed:@"ic_yuan_purple"];
    self.perImg.image = [UIImage imageNamed:@"ic_yuan"];
}
- (IBAction)clickPerButton:(id)sender {
    self.perImg.image = [UIImage imageNamed:@"ic_yuan_purple"];
    self.comImg.image = [UIImage imageNamed:@"ic_yuan"];
}
- (IBAction)clickYesButton:(id)sender {
    self.yesImg.image = [UIImage imageNamed:@"ic_yuan_purple"];
    self.noImg.image = [UIImage imageNamed:@"ic_yuan"];
    self.islocal = @"1";
}

- (IBAction)clickNoButton:(id)sender {
    self.noImg.image = [UIImage imageNamed:@"ic_yuan_purple"];
    self.yesImg.image = [UIImage imageNamed:@"ic_yuan"];
    self.islocal = @"2";
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

- (UIView *)darkView{
    if (!_darkView) {
        _darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        _darkView.userInteractionEnabled = YES;
    }
    return _darkView;
}

#pragma mark - 选择城市
- (IBAction)clcikCityButton:(id)sender {
//    if (self.pickerView) {
//        self.pickerView.hidden = NO;
//        return;
//    }
    self.pickerView = [[AddressView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height)];
//    [self.pickerView updateAddressAtProvince:@"北京市" city:@"北京市"];
    self.pickerView.delegate = self;
    self.pickerView.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:self.pickerView];
}

- (void)JSAddressCancleAction:(id)senter {
    [self.pickerView removeFromSuperview];
//    [self.cityBtn setTitle:@"北京市" forState:UIControlStateNormal];
}

-(void) JSAddressPickerRerurnBlockWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)town{
    [self.pickerView removeFromSuperview];
    NSString *addressStr = [NSString stringWithFormat:@"%@-%@-%@",province,city,town];
    [self.cityBtn setTitle:addressStr forState:UIControlStateNormal];
    self.provinceStr = province;
    self.cityStr = city;
}



#pragma mark - 选择店铺类型
- (IBAction)clickShopTypeButton:(id)sender {
    
    [self.view addSubview:self.darkView];
    NSLog(@"%f",CGRectGetMaxY(self.cityBtn.frame));
    self.menuView = [[YLDropDownMenu alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2 - 50, 70, 100, 400)];
    self.menuView.dataSource = @[@"美食",@"电影",@"酒店",@"外卖",@"休闲娱乐",@"周边游",@"生活服务",@"KTV",@"手机充值"];
    self.menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuView];
    __weak typeof(self)weakSelf = self;
    [self.menuView setFinishBlock:^(NSString *title){
        NSLog(@"%@",title);
        [weakSelf handleSingleTapGesture];
        [weakSelf.shopTypeBtn setTitle:title forState:UIControlStateNormal];
    }];
    [self.menuView setFinishRow:^(NSString *row){
        NSLog(@"%@",row);
        weakSelf.typeStr = row;
        [weakSelf handleSingleTapGesture];
    }];
}

- (void)handleSingleTapGesture{
    [self.darkView removeFromSuperview];
    [self.menuView removeFromSuperview];
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
    NSString *addressStr = [NSString stringWithFormat:@"%@%@",self.provinceStr,self.cityStr];
    [_helper upDataCreatShopInfoWithUserid:[ETUserInfo sharedETUserInfo].Id city:addressStr shopName:self.permitName.text legalperson:_legalPersonName.text phone:_phoneNumber.text type:self.typeStr businesslicense:_registerNumber.text address:_businessAddress.text idcard:_idcardNumber.text positive_pic:_firstPhotoName opposite_pic:_secondPhotoName license_pic:_thirdPhotoName islocal:self.islocal success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"提交信息成功"];
             [self clickBack];
        });
    } faild:^(NSString *response, NSError *error) {
        
    }];
//
//    ETShopInfoController *vc =[[ETShopInfoController alloc] initWithNibName:@"ETShopInfoController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:true];
   
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


// 返回按钮跳转首页
//func clickBack(){
//    let vc = ClassificationViewController()
//    var target:UIViewController?
//    
//    for controller in (self.navigationController?.viewControllers)! {
//        if controller.isKindOfClass(vc .classForCoder) {
//            target = controller
//        }
//    }
//    if (target != nil) {
//        self.navigationController?.popToViewController(target!, animated: true)
//    }
//}

-(void)clickBack{
    UINavigationController *nav = self.navigationController;
    NSMutableArray *mutarray = [[NSMutableArray alloc] init];
    for (UIViewController *vc in nav.viewControllers) {
        [mutarray addObject:vc];
        if ([vc isKindOfClass:[PersonViewController class]]) {
            break;
        }
    }
    [nav setViewControllers:mutarray animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}



@end