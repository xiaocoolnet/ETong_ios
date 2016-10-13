//
//  FootprintsViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "FootprintsViewController.h"
#import "FootprintsTableViewCell.h"
#import "ETShopHelper.h"
#import "ETGoodsDataModel.h"

@interface FootprintsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) ETShopHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation FootprintsViewController

-(ETShopHelper *)helper{
    if (!_helper) {
        _helper = [ETShopHelper helper];
    }
    return _helper;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self Getdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self addTableView];
//    [self Getdata];
}


-(void)Getdata{
    [self.helper GetFootprintsWithUserid:[ETUserInfo sharedETUserInfo].id Type:@"1" success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<response.count; i++) {
                
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
            }
            NSLog(@"%lu",(unsigned long)self.dataArray.count);
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}


-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FootprintsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FootprintsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ETGoodsDataModel *model = self.dataArray[indexPath.row];
    cell.goodsname.text = model.goodsname;
    cell.priceLab.text = [@"¥" stringByAppendingString:model.price];
    cell.contentLab.text = model.description;
    // 将string字符串转换为array数组
    NSArray  *array = [model.photo componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    ETGoodsDataModel *model = self.dataArray[indexPath.row];
    vc.goodModel = model;
    vc.goodModel.picture = model.photo;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
