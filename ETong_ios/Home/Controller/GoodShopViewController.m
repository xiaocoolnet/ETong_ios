//
//  GoodShopViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "GoodShopViewController.h"
#import "GoodShopCollectionViewCell.h"

@interface GoodShopViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) UIImageView *headerImage;
@property(nonatomic, strong) UIButton *btn;

@end

@implementation GoodShopViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    UISearchBar *view = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    view.userInteractionEnabled = false;
    self.navigationItem.titleView = view;

    [self addCollectionView];
    [self addLowView];
}

-(void)addLowView{
    NSArray *arr = @[@"宝贝分类",@"分享店铺",@"联系卖家"];
    for (int i = 0; i<3; i++) {
        UIButton *lowBtn = [[UIButton alloc] init];
        lowBtn.frame = CGRectMake((kScreenWidth/3)*i, kScreenHeight - 60 - 64, kScreenWidth/3, 60);
        lowBtn.backgroundColor = [UIColor whiteColor];
        [lowBtn setTitle:arr[i] forState:UIControlStateNormal];
        lowBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        [lowBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [self.view addSubview:lowBtn];
    }
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=10; //设置每一行的间距
    layout.itemSize=CGSizeMake(kScreenWidth/2-10, 220);  //设置每个单元格的大小
    layout.sectionInset=UIEdgeInsetsMake(0, 5, 5, 5);
    layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 200); //设置collectionView头视图的大小
    
    _collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.frame=CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64-60);
    //注册cell单元格
    [self.collection registerClass:[GoodShopCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
    return 10;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        //添加头视图的内容
        [self addContent];
        //头视图添加view
        [header addSubview:self.btn];
        [header addSubview:self.headerImage];
        return header;
    }
    
    return nil;
}
/*
 *  补充头部内容
 */
-(void)addContent
{
    UIImageView *headerImage=[[UIImageView alloc]init];
    headerImage.contentMode=UIViewContentModeScaleAspectFill;
    headerImage.clipsToBounds=YES;
    headerImage.frame=CGRectMake(0, 0, self.view.frame.size.width, 150);
    headerImage.image=[UIImage imageNamed:@"ic_lunbotu-1"];
    self.headerImage=headerImage;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 160, self.view.frame.size.width, 40);
    btn.backgroundColor = [UIColor whiteColor];
    self.btn = btn;
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(15, 0, 150, 40);
    lable.text = @"全部宝贝";
    lable.textAlignment = NSTextAlignmentLeft;
    [btn addSubview:lable];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
