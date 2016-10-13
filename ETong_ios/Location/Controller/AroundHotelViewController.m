//
//  AroundHotelViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AroundHotelViewController.h"
#import "HotelTableViewCell.h"
#import "LocationModel.h"
#import "EveryDayHelper.h"
#import "AllShopDetailViewController.h"

@interface AroundHotelViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) EveryDayHelper *helper;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation AroundHotelViewController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addTableView];
    [self getData];
}

-(void)getData{
    [self.helper getfoodsInfoWithCity:self.cityStr Type:@"3" success:^(NSArray *response) {
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 44) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HotelTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LocationModel *model = self.dataArray[indexPath.row];
    cell.nameLab.text = model.shopname;
//    cell.distanceLab.text = model.address;
    if ([model.level isEqualToString:@"0"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_0"];
    }else if ([model.level isEqualToString:@"0.5"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_0_5"];
    }else if ([model.level isEqualToString:@"1"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_1"];
    }else if ([model.level isEqualToString:@"1.5"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_1_5"];
    }else if ([model.level isEqualToString:@"2"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_2"];
    }else if ([model.level isEqualToString:@"2.5"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_2_5"];
    }else if ([model.level isEqualToString:@"3"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_3"];
    }else if ([model.level isEqualToString:@"3.5"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_3_5"];
    }else if ([model.level isEqualToString:@"4"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_4"];
    }else if ([model.level isEqualToString:@"4.5"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_4_5"];
    }else if ([model.level isEqualToString:@"5"]) {
        cell.img.image = [UIImage imageNamed:@"ic_yellowstar_5"];
    }
    
    
    return cell;
}

#pragma mark - 页面跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllShopDetailViewController *vc = [[AllShopDetailViewController alloc] init];
    LocationModel *model = self.dataArray[indexPath.item];
    vc.shopModel = model;
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
