//
//  ETLimitTimeController.m
//  ETong_ios
//
//  Created by xiaocool on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETLimitTimeController.h"
#import "ETLimitSaleCell.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"
@interface ETLimitTimeController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(weak, nonatomic) IBOutlet UIButton *timeBtn;
@property(weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ETLimitTimeController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.title = @"限时抢购";
    // Do any additional setup after loading the view from its nib.
    [_collectView registerNib:[UINib nibWithNibName:@"ETLimitSaleCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self getDate];
}

#pragma mark - 获取新品上市数据
-(void)getDate{
    
    [self.helper getNewProductInfoWithRecommend:@"2" success:^(NSArray *response) {
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
            [self.collectView reloadData];
            
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ETLimitSaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    cell.goodname.text = model.goodsname;
    cell.priceLab.text = [@"¥" stringByAppendingString:model.price];
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
    vc.goodModel = self.dataArray[btn.tag];
    vc.hidesBottomBarWhenPushed = true;
    vc.navgationType = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/2-10, 220);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
// 跳转详情页
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    vc.hidesBottomBarWhenPushed = true;
    vc.navgationType = @"1";
    vc.goodsid = model.id;
    vc.shopid = model.shopid;
    [self.navigationController pushViewController:vc animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end