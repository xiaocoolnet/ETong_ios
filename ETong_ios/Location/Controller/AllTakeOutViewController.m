//
//  AllTakeOutViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AllTakeOutViewController.h"
#import "TakeOutTableViewCell.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"
#import "LocationModel.h"

@interface AllTakeOutViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation AllTakeOutViewController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    [self GetDate];
}

-(void)GetDate{
    [self.helper getfoodsInfoWithCity:self.cityStr Type:@"4" success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                LocationModel *model = [LocationModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
                
            }
            [self.tableView reloadData];
            
        });
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 88) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TakeOutTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((LocationModel *)self.dataArray[section]).goodslist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 208;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TakeOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LocationModel *carmodel = self.dataArray[indexPath.section];
    ETGoodsDataModel *model = carmodel.goodslist[indexPath.row];
    cell.titleLab.text = carmodel.shopname;
    cell.addressLab.text = carmodel.address;
    cell.nameLab.text = model.goodsname;
    cell.priceLab.text = model.price;
    cell.opriceLab.text = model.pays;
    // 将string字符串转换为array数组
    NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(10, 80, self.view.frame.size.width - 20, 0.5);
    line.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [cell.contentView addSubview:line];
    if ([carmodel.level isEqualToString:@"0"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_0"];
    }else if ([carmodel.level isEqualToString:@"0.5"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_0_5"];
    }else if ([carmodel.level isEqualToString:@"1"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_1"];
    }else if ([carmodel.level isEqualToString:@"1.5"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_1_5"];
    }else if ([carmodel.level isEqualToString:@"2"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_2"];
    }else if ([carmodel.level isEqualToString:@"2.5"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_2_5"];
    }else if ([carmodel.level isEqualToString:@"3"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_3"];
    }else if ([carmodel.level isEqualToString:@"3.5"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_3_5"];
    }else if ([carmodel.level isEqualToString:@"4"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_4"];
    }else if ([carmodel.level isEqualToString:@"4.5"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_4_5"];
    }else if ([carmodel.level isEqualToString:@"5"]) {
        cell.imgView.image = [UIImage imageNamed:@"ic_yellowstar_5"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    LocationModel *carmodel = self.dataArray[indexPath.section];
    ETGoodsDataModel *model = carmodel.goodslist[indexPath.row];
    vc.goodsid = model.id;
    vc.shopid = model.shopid;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
