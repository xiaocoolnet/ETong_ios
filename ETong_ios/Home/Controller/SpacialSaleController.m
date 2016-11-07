//
//  SpacialSaleController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/11/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SpacialSaleController.h"
#import "ETSpecialSaleCell.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"
#import "CZCountDownView.h"

@interface SpacialSaleController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIView *timeView;
@property (nonatomic,strong) UICollectionView *collection;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SpacialSaleController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.title = @"天天特价";
    [self addCollectionView];
    [self getDate];
}
#pragma mark - 获取天天特价数据
-(void)getDate{
    
    [self.helper getNewProductInfoWithRecommend:@"3" success:^(NSArray *response) {
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
            [self.collection reloadData];
            
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}


-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=5; //设置每一行的间距
    layout.minimumInteritemSpacing = 5;
    layout.itemSize=CGSizeMake(kScreenWidth/2-15, 220);  //设置每个单元格的大小
//    layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 170); //设置collectionView头视图的大小
    
    _collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.frame=CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 40);
    //注册cell单元格
    [self.collection registerNib:[UINib nibWithNibName:@"ETSpecialSaleCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
    _collection.delegate=self;
    _collection.dataSource=self;
    _collection.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:_collection];
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
    ETSpecialSaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    cell.goodsname.text = model.goodsname;
    cell.priceLab.text = [@"¥" stringByAppendingString:model.price];
    cell.opriceLab.text = [@"¥" stringByAppendingString:model.oprice];
    // 将string字符串转换为array数组
    NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/2-15, 220);
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
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, 160)];
        view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [header addSubview:view];
        
        UIImageView *headerImage=[[UIImageView alloc]init];
        headerImage.contentMode=UIViewContentModeScaleAspectFill;
        headerImage.clipsToBounds=YES;
        headerImage.frame=CGRectMake(0, 0, self.view.frame.size.width, 110);
        headerImage.image=[UIImage imageNamed:@"ic_lunbotu-1"];
        [view addSubview:headerImage];
        
        self.timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, Screen_frame.size.width, 50)];
        self.timeView.backgroundColor = [UIColor colorWithRed:253/255.0 green:74/255.0 blue:75/255.0 alpha:1.0];
        [view addSubview:self.timeView];
        
        [self addHeaderView];
        
        return header;
    }
    
    return nil;
}

-(void) addHeaderView{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 60, 50)];
    lab.textColor = [UIColor whiteColor];
    lab.text = @"剩余时间";
    lab.font = [UIFont systemFontOfSize:15];
    [self.timeView addSubview:lab];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger time = round(interval);
    
    // 封装后
    CZCountDownView *countDown = [CZCountDownView countDown];
    countDown.frame = CGRectMake(100, 0, Screen_frame.size.width - 130, 50);
    countDown.timestamp = (1478833871 - time);
    countDown.timerStopBlock = ^{
        NSLog(@"时间停止");
    };
    [self.timeView addSubview:countDown];
    
    CZCountDownView *c1 = [CZCountDownView countDown];
    CZCountDownView *c2 = [CZCountDownView countDown];
    NSLog(@"%p--%p",c1,c2);
}



@end
