//
//  ETZBarScanController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETZBarScanController.h"
#import "ZBarSDK.h"

@interface ETZBarScanController ()<ZBarReaderViewDelegate>
@property (strong, nonatomic) ZBarReaderView *readerView;
@end

@implementation ETZBarScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = true;
    _readerView = [ZBarReaderView new];
    _readerView.readerDelegate = self;
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = _readerView.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
}

-(void)viewDidAppear:(BOOL)animated{
    [self configureUI];
}

- (void)configureUI{
    //自定义大小
    _readerView.frame = CGRectMake(20, 100, kScreenWidth-40, kScreenWidth-40);
    [self.view addSubview:_readerView];
    [_readerView start];
    UIView * scanImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 4)];
    scanImage.backgroundColor = [UIColor greenColor];
    scanImage.alpha = 0.7;
    [_readerView addSubview:scanImage];
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        scanImage.frame = CGRectMake(0, kScreenWidth-36, kScreenWidth-40, 4);
    } completion:nil];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(50, kScreenHeight-100, kScreenWidth-100,50);
    [cancelBtn addTarget:self action:@selector(cancelScan) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    cancelBtn.layer.cornerRadius = 8;
    [self.view addSubview:cancelBtn];
}

- (void)cancelScan{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark -----ZBarReaderViewDelegate----
- (void) readerView: (ZBarReaderView *) readerView
     didReadSymbols: (ZBarSymbolSet *) symbols
          fromImage: (UIImage *) image;{
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
