//
//  ShopCartController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ShopCartController.h"

@interface ShopCartController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *commodityList;
@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;
@property (weak, nonatomic) IBOutlet UILabel *totolPrice;
@property (weak, nonatomic) IBOutlet UIButton *sellBtn;
@property (assign,nonatomic) BOOL editState;
@end

@implementation ShopCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavEditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    [_commodityList registerNib:[UINib nibWithNibName:@"ETCommodityCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_commodityList registerNib:[UINib nibWithNibName:@"ETCommodityEditCell" bundle:nil] forCellReuseIdentifier:@"EditCell"];
}

- (void)rightNavEditBtnAction:(UIButton*)btn{
    if (_editState) {
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        _editState = false;
        [_commodityList reloadData];
    }else{
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        _editState = true;
        [_commodityList reloadData];
    }
}

- (void)touchSectionFromtitle:(UIButton *) btn{
    NSLog(@"%ld",(long)btn.tag);
}

- (void)touchSectionFromEdit:(UIButton *) btn {
    NSLog(@"%ld",(long)btn.tag);
}

#pragma mark ------TableviewDelegate/Datasource-----

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"ETShopCartHeader" owner:nil options:nil] firstObject];
    UIButton *titleBtn = [headerView viewWithTag:11];
    titleBtn.tag = section;
    [titleBtn addTarget:self action:@selector(touchSectionFromtitle:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *editBtn = [headerView viewWithTag:22];
    editBtn.tag = section;
    [editBtn addTarget:self action:@selector(touchSectionFromEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell* cell;
    if (_editState) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EditCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
