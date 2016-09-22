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
#import "NewProductsViewController.h"
#import "QualityLifeViewController.h"
#import "FreeViewController.h"

@interface HomePageController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *myColView;
@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell、sectionHeader
    [_myColView registerNib:[UINib nibWithNibName:@"ETDailyMarketCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    [_myColView registerNib:[UINib nibWithNibName:@"ETGuessYLikeCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    [_myColView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _myColView.scrollEnabled = false;
    
    [self configureUI];
}

- (void)rightNavBtnAction:(UIButton*)btn{
    
}

- (void)leftNavBtnAction:(UIButton*)btn{
    ETZBarScanController *vc =[[ETZBarScanController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self presentViewController:vc animated:true completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_myColView.contentSize.height > _myColView.frame.size.height) {
        CGFloat changeHeight = _myColView.contentSize.height-_myColView.frame.size.height;
        _viewHeightLayout.constant +=changeHeight;
        
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
    view.userInteractionEnabled = false;
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
}

#pragma mark - UPPartButtonAction

- (IBAction)limitSaleAction:(id)sender {
    ETLimitTimeController * controller = [[ETLimitTimeController alloc]initWithNibName:@"ETLimitTimeController" bundle:nil];
    [self.navigationController pushViewController:controller animated:true];
}
- (IBAction)dailySelectionAction:(id)sender {
}
- (IBAction)dailySpecialSaleAction:(id)sender {
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
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    }
    
    
    return cell;
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, kScreenWidth, 16)];
        if (indexPath.section ==0) {
            [imageView setImage:[UIImage imageNamed:@"ic_meirihaodian"]];
        }else{
            [imageView setImage:[UIImage imageNamed:@"ic_cainixihuan"]];
        }
        [headerView addSubview:imageView];
        headerView.backgroundColor = [UIColor whiteColor];
        
        return headerView;
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
@end