//
//  EAgentViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "EAgentViewController.h"
#import "ETShopHelper.h"
#import "ETGoodsDataModel.h"

@interface EAgentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) ETShopHelper *helper;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *imgArray;

@end

@implementation EAgentViewController

-(ETShopHelper *)helper{
    if (!_helper) {
        _helper = [ETShopHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.title = @"e代理";
    [self addTableView];
    self.dataArray = @[@"收支记录",@"体现记录",@"绑定体现账户"];
    self.imgArray = @[@"ic_shouzhijilu",@"ic_tixianjilu",@"ic_bangding"];
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 230)];
    self.backView.backgroundColor = [UIColor colorWithRed:253/255.0 green:74/255.0 blue:75/255.0 alpha:1.0];;
    self.tableView.tableHeaderView = self.backView;
    [self adddBackView];
}

-(void)adddBackView{
    UIImageView *bigimgView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2 - 90, 10, 200, 200)];
    bigimgView.image = [UIImage imageNamed:@"ic_beijing"];
    [self.backView addSubview:bigimgView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(bigimgView.frame.size.width/2 - 35, 30, 70, 20)];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:16];
    title.text = @"账户余额";
    title.textAlignment = NSTextAlignmentCenter;
    [bigimgView addSubview:title];
    
    UILabel *monLab = [[UILabel alloc] initWithFrame:CGRectMake(bigimgView.frame.size.width/2 - 60, 75, 120, 30)];
    monLab.text = @"0.00";
    monLab.font = [UIFont systemFontOfSize:19];
    monLab.textColor = [UIColor whiteColor];
    monLab.textAlignment = NSTextAlignmentCenter;
    [bigimgView addSubview:monLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(bigimgView.frame.size.width/2 - 40, 120, 80, 30)];
    [btn setImage:[UIImage imageNamed:@"ic_tixian"] forState:UIControlStateNormal];
    [bigimgView addSubview:btn];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, Screen_frame.size.width, 10)];
    lab.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.backView addSubview:lab];
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *nameLab =[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 49.5)];
    nameLab.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:nameLab];
    nameLab.text = self.dataArray[indexPath.row];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    [cell.contentView addSubview:imgView];
    imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, Screen_frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [cell.contentView addSubview:line];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 150)];
    headerView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width/2 - 0.5, 140)];
    leftView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:leftView];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2 + 0.5, 0, Screen_frame.size.width/2 - 0.5, 140)];
    rightView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:rightView];
    
    UILabel *monthnum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftView.frame.size.width, 30)];
    monthnum.text = @"本月接单数";
    monthnum.textAlignment = NSTextAlignmentCenter;
    monthnum.font = [UIFont systemFontOfSize:15];
    monthnum.textColor = [UIColor lightGrayColor];
    [leftView addSubview:monthnum];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, leftView.frame.size.width, 30)];
    numLab.textColor = [UIColor redColor];
    numLab.font = [UIFont systemFontOfSize:16];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.text =@"52";
    [leftView addSubview:numLab];
    
    UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, leftView.frame.size.width, 30)];
    allLab.textColor = [UIColor lightGrayColor];
    allLab.font = [UIFont systemFontOfSize:15];
    allLab.textAlignment = NSTextAlignmentCenter;
    allLab.text =@"总单数";
    [leftView addSubview:allLab];
    
    UILabel *allNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, leftView.frame.size.width, 30)];
    allNum.textColor = [UIColor redColor];
    allNum.font = [UIFont systemFontOfSize:16];
    allNum.textAlignment = NSTextAlignmentCenter;
    allNum.text =@"78";
    [leftView addSubview:allNum];
    
    UILabel *monthIncome = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightView.frame.size.width, 30)];
    monthIncome.text = @"本月收入";
    monthIncome.textAlignment = NSTextAlignmentCenter;
    monthIncome.font = [UIFont systemFontOfSize:15];
    monthIncome.textColor = [UIColor lightGrayColor];
    [rightView addSubview:monthIncome];
    
    UILabel *IncomeNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, rightView.frame.size.width, 30)];
    IncomeNum.textColor = [UIColor redColor];
    IncomeNum.font = [UIFont systemFontOfSize:16];
    IncomeNum.textAlignment = NSTextAlignmentCenter;
    IncomeNum.text =@"66";
    [rightView addSubview:IncomeNum];
    
    UILabel *AllIncome = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, rightView.frame.size.width, 30)];
    AllIncome.textColor = [UIColor lightGrayColor];
    AllIncome.font = [UIFont systemFontOfSize:15];
    AllIncome.textAlignment = NSTextAlignmentCenter;
    AllIncome.text =@"总收入";
    [rightView addSubview:AllIncome];
    
    UILabel *AllMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, rightView.frame.size.width, 30)];
    AllMoney.textColor = [UIColor redColor];
    AllMoney.font = [UIFont systemFontOfSize:16];
    AllMoney.textAlignment = NSTextAlignmentCenter;
    AllMoney.text =@"88";
    [rightView addSubview:AllMoney];
   
    
    return headerView;
}


@end
