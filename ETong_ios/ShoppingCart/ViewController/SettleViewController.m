//
//  SettleViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SettleViewController.h"
#import "SettleTableViewCell.h"

@interface SettleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textView;

@end

@implementation SettleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.title = @"确认订单";
    [self addTableView];
    [self addButton];
}

#pragma mark - 添加底部视图
-(void) addButton{
    UILabel *allPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_frame.size.height - 64 - 50, Screen_frame.size.width / 2.0, 50)];
    allPriceLab.backgroundColor = [UIColor whiteColor];
    allPriceLab.text = @" 合计: 7.0";
    [self.view addSubview:allPriceLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2.0, Screen_frame.size.height - 64 - 50, Screen_frame.size.width/2.0, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:btn];
}


#pragma mark - 添加TableView
-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 60) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SettleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 60)];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(addAddressBtn) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = backBtn;
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 10)];
    aview.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [backBtn addSubview:aview];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
    img.image = [UIImage imageNamed:@"ic_add"];
    [backBtn addSubview:img];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, Screen_frame.size.width - 50, 50)];
    lable.text = @"添加收货地址";
    lable.font = [UIFont systemFontOfSize:15];
    [backBtn addSubview:lable];
    
}

-(void) addAddressBtn{
    NSLog(@"223444");
    AdditionViewController *vc = [[AdditionViewController alloc] init];
    vc.title = @"收货地址";
    [self.navigationController pushViewController:vc animated:true];
}

/// 视图(tableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark - cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
#pragma mark - 分区头视图高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
#pragma mark - 分区尾视图高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 210;
}

#pragma mark - 分区头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(10, 5, 30, 30);
    img.image = [UIImage imageNamed:@"ic_dianpu"];
    [view addSubview:img];
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(50, 0, self.view.frame.size.width - 60, 40);
    name.text = @"小E";
    [view addSubview:name];
    return view;
}
#pragma mark - 分区尾视图设置
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *wayLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    wayLab.text = @"配送方式";
    [view addSubview:wayLab];
    
    UILabel *fastLab = [[UILabel alloc] initWithFrame:CGRectMake(Screen_frame.size.width - 140, 5, 130, 30)];
    fastLab.text = @"快递 免递";
    fastLab.textAlignment = NSTextAlignmentRight;
    [view addSubview:fastLab];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, Screen_frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel *NotesLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 150, 30)];
    NotesLab.text = @"备注";
    [view addSubview:NotesLab];
    
    self.textView = [[UITextField alloc] initWithFrame:CGRectMake(5, 100, Screen_frame.size.width - 10, 50)];
    self.textView.placeholder = @"留下你对卖家想说的话吧";
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.textColor = [UIColor lightGrayColor];
    [view addSubview:self.textView];
    
    UILabel *linea = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, Screen_frame.size.width, 0.5)];
    linea.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:linea];
    
    UILabel *xiaoji = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 80, 20)];
    xiaoji.text = @"小计";
    [view addSubview:xiaoji];
    
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(Screen_frame.size.width - 160, 170, 150, 20)];
    priceLab.textColor = [UIColor redColor];
    priceLab.textAlignment = NSTextAlignmentRight;
    priceLab.text = @"￥7";
    [view addSubview:priceLab];
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 200, Screen_frame.size.width, 10)];
    aview.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [view addSubview:aview];
    
    return view;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];
}


@end
