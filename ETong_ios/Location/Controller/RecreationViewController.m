//
//  RecreationViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "RecreationViewController.h"
#import "RecreationCollectionViewCell.h"

@interface RecreationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collection;

@end

@implementation RecreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self addCollectionView];
    
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=10; //设置每一行的间距
    layout.itemSize=CGSizeMake(kScreenWidth/4 - 10, 40);  //设置每个单元格的大小
    layout.sectionInset=UIEdgeInsetsMake(10, 5, 10, 5);
    
    _collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.frame=CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64);
    //注册cell单元格
    [self.collection registerClass:[RecreationCollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    _collection.delegate=self;
    _collection.dataSource=self;
    _collection.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:_collection];
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 10;
    }else if (section == 2){
        return 3;
    }else{
        return 2;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecreationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSArray *arr = @[@"足疗保健",@"洗浴",@"温泉",@"中医养生"];
        cell.nameLab.text = arr[indexPath.item];
    }else if (indexPath.section == 1){
        NSArray *arr = @[@"KTV",@"密室",@"娱乐游戏",@"DIY手工坊",@"网吧网咖",@"私人影院",@"棋牌室",@"桌面游戏",@"真人CS",@"桌球馆"];
        cell.nameLab.text = arr[indexPath.item];
    }else if (indexPath.section == 2){
        NSArray *arr = @[@"酒吧",@"咖啡馆",@"茶馆"];
        cell.nameLab.text = arr[indexPath.item];
    }else{
        NSArray *arr = @[@"农家乐",@"运动健身"];
        cell.nameLab.text = arr[indexPath.item];
    }
    
    return cell;
    
    
    
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 60)];
        
        if (indexPath.section ==0) {
            [imageView setImage:[UIImage imageNamed:@"ic_lunbotu-1"]];
            [headerView addSubview:imageView];
//            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }else if (indexPath.section == 1){
            [imageView setImage:[UIImage imageNamed:@"ic_lunbotu"]];
            [headerView addSubview:imageView];
//            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
            
        }else if (indexPath.section == 2){
            [imageView setImage:[UIImage imageNamed:@"ic_lunbotu-1"]];
            [headerView addSubview:imageView];
//            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }else{
            [imageView setImage:[UIImage imageNamed:@"ic_lunbotu"]];
            [headerView addSubview:imageView];
//            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kScreenWidth,60};
}

@end
