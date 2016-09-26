//
//  AroundTravelViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AroundTravelViewController.h"
#import "HotelTableViewCell.h"

@interface AroundTravelViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *aview;

@end

@implementation AroundTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
}

#pragma mark - 创建TableView
-(void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.aview = [[UIView alloc] init];
    self.aview.frame = CGRectMake(0, 0, Screen_frame.size.width, 220);
    self.aview.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.aview;
    [self addHeaderView];
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(0, 230, Screen_frame.size.width, 40);
    lable.text = @"热门推荐";
    lable.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    return lable;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    return cell;
}


#pragma mark - 创建透视图
-(void)addHeaderView{
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake((Screen_frame.size.width)/4.0 * i, 0, (Screen_frame.size.width)/4.0, 100);
        NSArray *arr = @[@"ic_waimai",@"ic_waimai",@"ic_waimai",@"ic_waimai"];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake((btn.frame.size.width - 70)/2.0 + (btn.frame.size.width * i), 10, 70, 70);
        [button setImage:[UIImage imageNamed:arr[i]]forState:UIControlStateNormal];
        [self.aview addSubview:button];
        button.layer.cornerRadius = 35;
        button.clipsToBounds = YES;
    
        NSArray *array = @[@"自然风光",@"名胜古迹",@"公园游乐场",@"温泉",];
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake((Screen_frame.size.width)/4.0 * i, 80, (Screen_frame.size.width )/4.0, 20);
        lable.text = array[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor whiteColor];
        lable.font = [UIFont systemFontOfSize:16];
        [self.aview addSubview:lable];
    }
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake((Screen_frame.size.width)/4.0 * i, 110, (Screen_frame.size.width )/4.0, 100);
        NSArray *arr = @[@"ic_waimai",@"ic_waimai",@"ic_waimai",@"ic_waimai"];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake((btn.frame.size.width - 70)/2.0 + (btn.frame.size.width * i), 110, 70, 70);
        [button setImage:[UIImage imageNamed:arr[i]]forState:UIControlStateNormal];
        [self.aview addSubview:button];
        button.layer.cornerRadius = 35;
        button.clipsToBounds = YES;
        NSArray *array = @[@"海洋馆",@"度假村",@"景点",@"全部"];
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake((Screen_frame.size.width)/4.0 * i, 180, (Screen_frame.size.width )/4.0, 20);
        lable.text = array[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15];
        [self.aview addSubview:lable];
    }
}

@end
