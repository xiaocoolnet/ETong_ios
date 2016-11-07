//
//  HomePageController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "HomePageController.h"
#import "SDCycleScrollView.h"
#import "ETZBarScanController.h"
#import "ETLimitTimeController.h"
#import "ETDailySpecialController.h"
#import "SpacialSaleController.h"
#import "NewProductsViewController.h"
#import "QualityLifeViewController.h"
#import "FreeViewController.h"
#import "EveryDayHelper.h"
#import "ETDailyMarketCell.h"
#import "ETGuessYLikeCell.h"
#import "NewProductModel.h"
#import "GoodShopViewController.h"
#import "SearchViewController.h"
#import "ClassificationView.h"
#import "ClassificationModel.h"
#import "ClassificationViewController.h"

@interface HomePageController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *myColView;
@property (weak, nonatomic) IBOutlet UIScrollView *backScroll;
@property (strong, nonatomic) EveryDayHelper *helper;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *likeArray;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageVie;

@property (nonatomic, strong)ClassificationView *menuView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong)UIView *darkView;

@end

@implementation HomePageController


-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell、sectionHeader
    [_myColView registerNib:[UINib nibWithNibName:@"ETDailyMarketCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    [_myColView registerNib:[UINib nibWithNibName:@"ETGuessYLikeCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    [_myColView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _myColView.scrollEnabled = false;
    [self configureUI];
//    [self reloadate];
    [self getDate];
    [self getData];
    [self getFenLeiList];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture)];
    singleTap.numberOfTapsRequired = 1;
    [self.darkView addGestureRecognizer:singleTap];
}

- (void)handleSingleTapGesture{
    [self.darkView removeFromSuperview];
    [self.menuView removeFromSuperview];
}

- (UIView *)darkView{
    if (!_darkView) {
        _darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        _darkView.userInteractionEnabled = YES;
    }
    return _darkView;
}

#pragma mark - 获取每日好店数据
-(void)getDate{
    
    [self.helper getGoodShopInfoWithType:@"10" success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                ETShopModel *model = [ETShopModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
                 NSLog(@"%@",model);
                NSLog(@"lalalalala");
                NSLog(@"%@",self.dataArray);
                NSLog(@"%@",model.shopname);
//                NSLog(@"%@",self.dataArray[i][@"shopname"]);
            }
            [self.myColView reloadData];
            [self reloadate];
            
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}
#pragma mark - 获取猜你喜欢
-(void)getData{
    
    [self.helper getGoodShopInfoWithIsLike:nil success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.likeArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                [self.likeArray addObject:model];
        
            }
            [self.myColView reloadData];
            [self reloadate];
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}



- (void)rightNavBtnAction:(UIButton*)btn{
    
}

- (void)leftNavBtnAction:(UIButton*)btn{
//    ETZBarScanController *vc =[[ETZBarScanController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self presentViewController:vc animated:true completion:nil];
    [self.view addSubview:self.darkView];
    CGFloat num = 0;
    if (self.dataSource.count%4 == 0) {
        num = self.dataSource.count / 4;
    }else{
        num = self.dataSource.count / 4 + 1;
    }
    self.menuView = [[ClassificationView alloc] initWithFrame:CGRectMake(0, 70, Screen_frame.size.width, 40*num + 50)];
    self.menuView.dataSource = self.dataSource;
    self.menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuView];
    __weak typeof(self)weakSelf = self;
    [self.menuView setFinishBlock:^(NSString *title){
        NSLog(@"%@",title);
        [weakSelf handleSingleTapGesture];
        ClassificationViewController *vc = [[ClassificationViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.nameStr = title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (_backScroll.contentOffset.y == 0) {
//        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
//    }
//    if (_myColView.contentSize.height > _myColView.frame.size.height) {
//        CGFloat changeHeight = _myColView.contentSize.height-_myColView.frame.size.height;
//        _viewHeightLayout.constant +=changeHeight;
//        
//    }
    [self reloadate];
}

- (void) reloadate{
    if (_backScroll.contentOffset.y == 0) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    }
//    if (_myColView.contentSize.height > _myColView.frame.size.height) {
//        CGFloat changeHeight = _myColView.contentSize.height-_myColView.frame.size.height;
//        _viewHeightLayout.constant +=changeHeight;
//        
//    }
    if (CGRectGetMinY(_myColView.frame)+_myColView.contentSize.height > kScreenHeight) {
//        CGFloat changeHeight = _myColView.contentSize.height-_myColView.frame.size.height;
        _viewHeightLayout.constant = CGRectGetMinY(_myColView.frame)+_myColView.contentSize.height;
        
    }
}

- (void)configureUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = true;//不设置为黑色背景
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn1 setImage:[UIImage imageNamed:@"ic_xiaoxi"] forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn2 setImage:[UIImage imageNamed:@"ic_shezhi"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"ic_saoyisao"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    self.navigationItem.leftBarButtonItem = item3;
    UISearchBar *view = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    view.userInteractionEnabled = YES;
    view.delegate=self;
    [view resignFirstResponder];
    self.navigationItem.titleView = view;
    
    NSArray *imageNames = @[@"ic_lunbotu-1",
                            @"ic_lunbotu-1",
                            @"ic_lunbotu-1",
                            @"ic_lunbotu-1",
                            @"ic_lunbotu-1"
                            ];
    // Do any additional setup after loading the view from its nib.
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, _headView.frame.size.height) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [_headView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageVie = [[UIImageView alloc] init];
}

#pragma mark - UPPartButtonAction

- (IBAction)limitSaleAction:(id)sender {
    ETLimitTimeController * controller = [[ETLimitTimeController alloc]initWithNibName:@"ETLimitTimeController" bundle:nil];
    [self.navigationController pushViewController:controller animated:true];
}
- (IBAction)dailySelectionAction:(id)sender {
    ETDailySpecialController * cotroller = [[ETDailySpecialController alloc]initWithNibName:@"ETDailySpecialController" bundle:nil];
    [self.navigationController pushViewController:cotroller animated:true];
}
- (IBAction)dailySpecialSaleAction:(id)sender {
//    SpacialSaleController *controller = [[SpacialSaleController alloc]initWithNibName:@"ETSpacialSaleController" bundle:nil];
    SpacialSaleController *controller = [[SpacialSaleController alloc] init];
    [self.navigationController pushViewController:controller animated:true];
}
- (IBAction)qualityLifeAction:(id)sender {
    QualityLifeViewController *vc = [[QualityLifeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)newGoodsAction:(id)sender {
    NewProductsViewController *vc = [[NewProductsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)freeOfCharge:(id)sender {
    FreeViewController *vc = [[FreeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }else{
        return self.likeArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ETDailyMarketCell *cell;
    [self reloadate];
    if (indexPath.section == 0) {
        ETDailyMarketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        ETShopModel * model = self.dataArray[indexPath.item];
        cell.nameLab.text = model.shopname;
        cell.busisLab.text = [model.businesslicense stringByAppendingString:@"人已收藏"];
        NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,model.photo];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
        NSLog(@"%@",model.shopname);
//        [self reloadate];
        return cell;
    }else{
        ETGuessYLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        ETGoodsDataModel * model = self.likeArray[indexPath.item];
        cell.titleLab.text = model.goodsname;
        cell.priceLab.text = [@"¥" stringByAppendingString:model.price];
        cell.busisLab.text = [model.recommend stringByAppendingString:@"人已收藏"];
        // 将string字符串转换为array数组
        NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
        NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
//        [self reloadate];
        return cell;
    }
    
    
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, kScreenWidth, 16)];
        
        if (indexPath.section ==0) {
            self.imageVie.frame = CGRectMake(0, 2, kScreenWidth, 16);
            [self.imageVie setImage:[UIImage imageNamed:@"ic_meirihaodian"]];
            [headerView addSubview:self.imageVie];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;

        }else{
            self.imageView.frame = CGRectMake(0, 2, kScreenWidth, 16);
            [self.imageView setImage:[UIImage imageNamed:@"ic_cainixihuan"]];
            [headerView addSubview:self.imageView];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;

        }
        
    }
    return nil;
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        return (CGSize){(kScreenWidth-20)/2 ,(kScreenWidth-20)/2};
    }
    if (kScreenWidth == 320) {
        return (CGSize){(kScreenWidth-20)/2 ,(kScreenWidth-20)*3/4};
    }
    return (CGSize){(kScreenWidth-20)/2 ,(kScreenWidth-20)*3/5};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kScreenWidth,20};
}

#pragma mark - collectionView跳转页面
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GoodShopViewController *vc = [[GoodShopViewController alloc] init];
        ETShopModel *model = self.dataArray[indexPath.item];
        vc.shopModel = model;
        vc.shopModel.uid = model.uid;
        NSLog(@"%@",vc.shopModel.uid);
        NSLog(@"%@",model.uid);
        vc.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ETGoodsDetailController *controller = [[ETGoodsDetailController alloc]init];
        ETGoodsDataModel *model = self.likeArray[indexPath.row];
//        controller.goodModel = model;
        controller.hidesBottomBarWhenPushed = YES;
        controller.navgationType = @"1";
        controller.goodsid = model.id;
        controller.shopid = model.shopid;
        [self.navigationController pushViewController:controller animated:true];
    }
}

-(void)clickLowButton{
//    ChetViewController *vc = [[ChetViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.receive_uid = self.shopModel.uid;
//    vc.title = self.shopModel.shopname;
//    if ([[ETUserInfo sharedETUserInfo].Id isEqualToString:self.shopModel.uid]) {
//        [SVProgressHUD showErrorWithStatus:@"这是您自己的店铺，不能和自己聊天"];
//        return;
//    }
//    if (![ETUserInfo sharedETUserInfo].isLogin) {
//        [SVProgressHUD showErrorWithStatus:@"请先去登录"];
//        return;
//    }
//    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *vc = [[SearchViewController alloc] init];
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
    return true;
}

#pragma mark - ScrollViewDelegate -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollY = scrollView.contentOffset.y;
    [self.view endEditing:true];
    if (scrollY>0&&scrollY<200) {
        self.navigationController.navigationBar.hidden = false;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:scrollY/200];
    }else if (scrollY > 200){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }else if (scrollY <=0){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    }
}

#pragma mark - 获取首页分类列表一级
- (void)getFenLeiList{
    [self.helper getGoodsListsuccess:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataSource = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                ClassificationModel *model = [ClassificationModel mj_objectWithKeyValues:response[i]];
                [self.dataSource addObject:model];
            }
            
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

@end