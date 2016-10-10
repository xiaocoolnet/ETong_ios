//
//  NewPeopleViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/10.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "NewPeopleViewController.h"

#import "SDCycleScrollView.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"
#import "NowDayTableViewCell.h"

@interface NewPeopleViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIView *aview;

@end

@implementation NewPeopleViewController

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
    [self addCollectionView];
    [self getData];
}
#pragma mark - 创建tableView及透视图
-(void)addCollectionView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NowDayTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
    self.aview.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.tableView.tableHeaderView = self.aview;
    
    NSArray *imageNames = @[@"ic_lunbotu",
                            @"ic_lunbotu",
                            @"ic_lunbotu",
                            @"ic_lunbotu",
                            @"ic_lunbotu" // 本地图片请填写全名
                            ];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 160) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    //    [_headView addSubview:cycleScrollView];
    [self.aview addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
    [self createSegmentedControl];
}
#pragma mark - 创建选择器UISegmentedControl
- (void) createSegmentedControl{
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"智能排序", @"价格不限"]];
    self.segment.frame = CGRectMake(0, 170, self.view.frame.size.width, 30);
    [self.aview addSubview:self.segment];
    self.segment.selectedSegmentIndex = 0;
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.tintColor = [UIColor whiteColor];
    // 正常状态下
    NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.segment setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    // 选中状态下
    NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:17.0f],NSForegroundColorAttributeName : [UIColor redColor]};
    [self.segment setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
    [self.segment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    
}
#pragma mark - 点击segment的时候的出方法
- (void)segAction:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.segment.selectedSegmentIndex = 0;
            [self getData];
            break;
        case 1:
            self.segment.selectedSegmentIndex = 1;
            [self getData];
            break;
        default:
            break;
    }
}
#pragma mark - 数据解析
-(void)getData{
    [self.helper NewPeoplesuccess:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
                
            }
            [self.tableView reloadData];
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NowDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    cell.nameLab.text = model.goodsname;
    cell.opriceLab.text = model.oprice;
    NSInteger price = [model.oprice integerValue] - [model.price integerValue];
    cell.priceLab.text = [NSString stringWithFormat:@"立减%ld",(long)price];
    cell.priceLab.layer.borderWidth = 1;
    cell.priceLab.layer.borderColor = [UIColor redColor].CGColor;
    cell.priceLab.layer.cornerRadius = 10;
    cell.priceLab.textAlignment = NSTextAlignmentCenter;
    // 将string字符串转换为array数组
    NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    [cell.priceBtn setTitle:[NSString stringWithFormat:@"￥%@马上抢",model.price] forState:UIControlStateNormal];
    cell.priceBtn.tag = indexPath.row;
    [cell.priceBtn addTarget:self action:@selector(clickPriceBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark - 页面跳转
-(void)clickPriceBtn:(UIButton *)sender{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    vc.goodModel = self.dataArray[sender.tag];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
