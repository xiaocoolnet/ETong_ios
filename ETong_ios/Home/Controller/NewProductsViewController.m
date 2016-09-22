//
//  NewProductsViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "NewProductsViewController.h"
#import "NewProductCollectionViewCell.h"

@interface NewProductsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UICollectionView *collection;

@end

@implementation NewProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.title = @"新品上市";
    [self addCollectionView];
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=10; //设置每一行的间距
    layout.itemSize=CGSizeMake(kScreenWidth/2-10, 220);  //设置每个单元格的大小
    layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 200); //设置collectionView头视图的大小
    
    _collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.frame=CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 40);
    //注册cell单元格
    [self.collection registerClass:[NewProductCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
    NewProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
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
    headerImage.frame=CGRectMake(0, 0, self.view.frame.size.width, 200);
    headerImage.image=[UIImage imageNamed:@"ic_lunbotu-1"];
    self.headerImage=headerImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
