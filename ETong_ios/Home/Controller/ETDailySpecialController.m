//
//  ETDailySpecialController.m
//  ETong_ios
//
//  Created by xiaocool on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETDailySpecialController.h"
#import "ETDailySpacialCell.h"

@interface ETDailySpecialController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *goodstableView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation ETDailySpecialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日精选";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    [self.goodstableView registerNib:[UINib nibWithNibName:@"ETDailySpacialCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.goodstableView.tableFooterView = [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

@end
