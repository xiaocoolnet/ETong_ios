//
//  ETDailySpecialController.m
//  ETong_ios
//
//  Created by xiaocool on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETDailySpecialController.h"
#import "ETDailySpacialCell.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"

@interface ETDailySpecialController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *goodstableView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ETDailySpecialController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日精选";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    [self.goodstableView registerNib:[UINib nibWithNibName:@"ETDailySpacialCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.goodstableView.tableFooterView = [[UIView alloc]init];
    [self getDate];
}

#pragma mark - 获取每日精选数据
-(void)getDate{
    
    [self.helper getNewProductInfoWithRecommend:@"5" success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
                NSLog(@"%@",model);
                NSLog(@"lalalalala");
                NSLog(@"%@",self.dataArray);
            }
            [self.goodstableView reloadData];
            
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    ETDailySpacialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ETGoodsDataModel *model = self.dataArray[indexPath.row];
    cell.goodnameLab.text = model.goodsname;
    cell.priceLab.text = [@"¥" stringByAppendingString:model.price];
    cell.opriceLab.text = [@"¥" stringByAppendingString:model.oprice];
    cell.nameLab.text = model.description;
    // 将string字符串转换为array数组
    NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    cell.sureBtn.tag = indexPath.row;
    [cell.sureBtn addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)clickSureBtn:(UIButton *)btn{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    ETGoodsDataModel *model = self.dataArray[btn.tag];
    vc.hidesBottomBarWhenPushed = true;
    vc.navgationType = @"1";
    vc.goodsid = model.id;
    vc.shopid = model.shopid;
    [self.navigationController pushViewController:vc animated:YES];
}

// 跳转详情页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    vc.hidesBottomBarWhenPushed = true;
    vc.navgationType = @"1";
    vc.goodsid = model.id;
    vc.shopid = model.shopid;
    NSLog(@"qqwedf=%@",vc.goodsid);
    [self.navigationController pushViewController:vc animated:YES];
}


@end
