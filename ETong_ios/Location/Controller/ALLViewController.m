//
//  ALLViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ALLViewController.h"
#import "AllTableViewCell.h"

@interface ALLViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ALLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[AllTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(0, 0, Screen_frame.size.width, 150);
    img.image = [UIImage imageNamed:@"ic_lunbotu-1"];
    self.tableView.tableHeaderView = img;
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.nameLab.text = @"美女";
    cell.addressLab.text = @"烟台市";
        
    return cell;
}




@end
