//
//  AllEBuyingViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AllEBuyingViewController.h"
#import "AllEBuyingTableViewCell.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"


@interface AllEBuyingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) EveryDayHelper *helper;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation AllEBuyingViewController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self addTableView];
    [self getData];
}

-(void)getData{
    [self.helper success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                NSLog(@"%@",model.shop_list.firstObject[@"level"]);
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AllEBuyingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllEBuyingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    cell.goodsname.text = model.goodsname;
    cell.contentLab.text = model.description;
    cell.opriceLab.text = model.oprice;
    cell.priceLab.text = model.price;
    // 将string字符串转换为array数组
    NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    cell.buyButton.tag = indexPath.row;
    [cell.buyButton addTarget:self action:@selector(clickBuybtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)clickBuybtn:(UIButton *)sender{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    vc.goodModel = self.dataArray[sender.tag];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
