//
//  AllItemizeViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/11/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "AllItemizeViewController.h"
#import "RecreationCollectionViewCell.h"

@interface AllItemizeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collection;

@end

@implementation AllItemizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self addCollectionView];
    
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 30)/4.0, 40);
    
    _collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.frame=CGRectMake(10, 0, Screen_frame.size.width - 20, Screen_frame.size.height - 64);
    //注册cell单元格
    [self.collection registerClass:[RecreationCollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    _collection.delegate=self;
    _collection.dataSource=self;
    _collection.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    _collection.showsVerticalScrollIndicator = false;
    [self.view addSubview:_collection];
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 12;
    }else if (section == 1){
        return 10;
    }else if (section == 2){
        return 11;
    }else if (section == 3){
        return 10;
    }else if (section == 4){
        return 11;
    }
    else{
        return 9;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecreationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        NSArray *arr = @[@"足疗保健",@"洗浴",@"温泉",@"中医养生",@"KTV",@"密室",@"娱乐游戏",@"DIY手工坊",@"网吧网咖",@"私人影院",@"棋牌室",@"桌面游戏"];
        cell.nameLab.text = arr[indexPath.item];
    }else if (indexPath.section == 1){
        NSArray *arr = @[@"酒吧",@"咖啡馆",@"茶馆",@"农家乐",@"运动健身",@"网吧网咖",@"私人影院",@"桌面游戏",@"真人CS",@"桌球馆"];
        
        cell.nameLab.text = arr[indexPath.item];
    }else if (indexPath.section == 2){
        NSArray *arr = @[@"酒吧",@"咖啡馆",@"茶馆",@"足疗保健",@"洗浴",@"温泉",@"中医养生",@"KTV",@"密室",@"农家乐",@"运动健身"];
        cell.nameLab.text = arr[indexPath.item];
    }else if (indexPath.section == 3){
        NSArray *arr = @[@"酒吧",@"咖啡馆",@"茶馆",@"足疗保健",@"洗浴",@"温泉",@"中医养生",@"KTV",@"密室",@"农家乐"];
        cell.nameLab.text = arr[indexPath.item];
    }else if (indexPath.section == 4){
        NSArray *arr = @[@"酒吧",@"咖啡馆",@"茶馆",@"足疗保健",@"洗浴",@"温泉",@"中医养生",@"KTV",@"密室",@"农家乐",@"运动健身"];
        cell.nameLab.text = arr[indexPath.item];
    }else{
        NSArray *arr = @[@"茶馆",@"足疗保健",@"洗浴",@"温泉",@"中医养生",@"KTV",@"密室",@"农家乐",@"运动健身"];
        cell.nameLab.text = arr[indexPath.item];
    }
    cell.nameLab.font = [UIFont systemFontOfSize:15];
    return cell;
    
    
    
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
        NSArray *imgArr = @[@"ic_meishi",@"ic_dianying",@"ic_jiudian",@"ic_yule",@"ic_zhoubianyou-0",@"ic_shenghuo",@"ic_ktv"];
        
        [imageView setImage:[UIImage imageNamed:imgArr[indexPath.section]]];
        [headerView addSubview:imageView];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kScreenWidth,40};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}


@end
