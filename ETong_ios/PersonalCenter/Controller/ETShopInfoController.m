//
//  ETShopInfoController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETShopInfoController.h"
#import "ETWaitForAuditVC.h"
@interface ETShopInfoController ()
@property (weak, nonatomic) IBOutlet UITextView *shopDecrbe;
@end

@implementation ETShopInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核信息";
    // Do any additional setup after loading the view from its nib.
    _shopDecrbe.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _shopDecrbe.layer.borderWidth = 1;
}

- (IBAction)nextStep:(id)sender{
    ETWaitForAuditVC *vc = [[ETWaitForAuditVC alloc] initWithNibName:@"ETWaitForAuditVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

@end
