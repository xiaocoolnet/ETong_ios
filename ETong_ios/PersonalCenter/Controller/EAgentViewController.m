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
@property (strong, nonatomic) NSMutableArray *dataArray;

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
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.title = @"e代理";
    [self addTableView];
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 44) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


@end
