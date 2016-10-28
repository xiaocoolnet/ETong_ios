//
//  SettleViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SettleViewController.h"
#import "SettleTableViewCell.h"
#import "JSCartModel.h"
#import "ETShopHelper.h"
#import "JSCartViewController.h"

@interface SettleViewController ()<UITableViewDelegate, UITableViewDataSource, choosenameidArray>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textView;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;
@property (strong, nonatomic) ETShopHelper *helper;

@end

@implementation SettleViewController

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
    self.title = @"确认订单";
    [self addTableView];
    [self addButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self addTableView];
//    [self.tableView reloadData];
}

#pragma mark - 添加底部视图
-(void) addButton{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    float allPrice = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        arr = self.dataArray[i];
        for (int j = 0; j < arr.count; j++) {
            JSCartModel *model = arr[j];
            allPrice += model.p_price * model.p_quantity;
        }
    }
    
    UILabel *allPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, Screen_frame.size.height - 64 - 50, Screen_frame.size.width / 2.0, 50)];
    allPriceLab.backgroundColor = [UIColor whiteColor];
    allPriceLab.text = [@"合计:￥" stringByAppendingString: [NSString stringWithFormat:@"%.2f",allPrice]];
    allPriceLab.textColor = [UIColor redColor];
    [self.view addSubview:allPriceLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_frame.size.width/2.0, Screen_frame.size.height - 64 - 50, Screen_frame.size.width/2.0, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:btn];
}

#pragma mark - 提交订单
-(void)clickBtn{
    NSString *nameStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
    NSString *addressStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"address"];
    if (nameStr.length == 0 || phoneStr.length == 0 || addressStr.length == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请添加地址"];
    }else{
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.dataArray.count; i++) {
            arr = self.dataArray[i];
            for (int j = 0; j < arr.count; j++) {
                JSCartModel *model = arr[j];
                NSString *moeny = [NSString stringWithFormat:@"%.2f",model.p_price*model.p_quantity];
                NSString *goodid = model.p_id;
                NSLog(@"%@",goodid);
                NSString *num = [NSString stringWithFormat:@"%.2ld",(long)model.p_quantity];
                [self.helper PayInfoWithUserid:[ETUserInfo sharedETUserInfo].Id peoplename:nameStr address:addressStr goodsid:goodid goodnum:num mobile:phoneStr remark:self.textView.text money:moeny success:^(NSDictionary *response) {
                    st_dispatch_async_main(^{
                        [SVProgressHUD showSuccessWithStatus:@"结算成功"];
                        [self deleteShopCar];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                    
                } faild:^(NSString *response, NSError *error) {
                    [SVProgressHUD showSuccessWithStatus:@"结算失败"];
                }];
            }
        }
    }
}

-(void)deleteShopCar{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i++) {
        arr = self.dataArray[i];
        for (int j = 0; j < arr.count; j++) {
            JSCartModel *model = arr[j];
            NSString *goodid = model.p_id;
            [self.helper deleteShoppingCartWithGoodsid:goodid success:^(NSDictionary *response) {
                
            } faild:^(NSString *response, NSError *error) {
                
            }];
        }
    }
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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 190)];
    backView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = backView;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 60)];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(addAddressBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
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
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"phone"].length > 0) {
        
        lable.text = @"更改收货地址";
        
        UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, Screen_frame.size.width, 40)];
        phoneLab.backgroundColor = [UIColor whiteColor];
        phoneLab.text = [@"  手机号：    " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"phone"]];
        phoneLab.font = [UIFont systemFontOfSize:15];
        [backView addSubview:phoneLab];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 110.5, Screen_frame.size.width, 39.5)];
        nameLab.backgroundColor = [UIColor whiteColor];
        nameLab.text = [@"  姓名：    " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"name"]];
        nameLab.font = [UIFont systemFontOfSize:15];
        [backView addSubview:nameLab];
        
        UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 150.5, Screen_frame.size.width, 39.5)];
        addressLab.backgroundColor = [UIColor whiteColor];
        addressLab.text = [@"  " stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"address"]];
        addressLab.font = [UIFont systemFontOfSize:16];
        addressLab.textColor = [UIColor lightGrayColor];
        [backView addSubview:addressLab];
    }
}

-(void) addAddressBtn{
    NSLog(@"223444");
    AdditionViewController *vc = [[AdditionViewController alloc] init];
    vc.title = @"收货地址";
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:true];
}

//#pragma mark - 代理传值
- (void)choosenameid:(NSString * _Nonnull)name phone:(NSString * _Nonnull)phone address:(NSString * _Nonnull)address;{
    self.userName = name;
    self.phone = phone;
    self.address = address;
}

/// 视图(tableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
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
    
    JSCartModel *model = [self.dataArray[section] firstObject];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(10, 5, 30, 30);
    img.image = [UIImage imageNamed:@"ic_dianpu"];
    [view addSubview:img];
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(50, 0, self.view.frame.size.width - 60, 40);
    name.text = model.s_name;
    
    [view addSubview:name];
    return view;
}
#pragma mark - 分区尾视图设置
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    float price = 0;
    for (int i = 0; i < [self.dataArray[section] count]; i++) {
        JSCartModel *model = self.dataArray[section][i];
        price += model.p_price*model.p_quantity;
    }
    
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
    priceLab.text = [@"￥" stringByAppendingString: [NSString stringWithFormat:@"%.2f",price]] ;
    [view addSubview:priceLab];
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 200, Screen_frame.size.width, 10)];
    aview.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [view addSubview:aview];
    
    return view;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    JSCartModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.nameLab.text = model.p_name;
    cell.priceLab.text = [@"￥" stringByAppendingString: [NSString stringWithFormat:@"%.2f",model.p_price]];
    cell.numLab.text = [NSString stringWithFormat:@"%ld",(long)model.p_quantity];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.p_imageUrl]];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
