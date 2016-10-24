//
//  ClassificationView.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ClassificationView.h"
#import "RecreationCollectionViewCell.h"
#import "ClassificationModel.h"

@interface ClassificationView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;

@end

@implementation ClassificationView


- (void)drawRect:(CGRect)rect {
    NSLog(@"%lu", (unsigned long)self.dataSource.count);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        self.backgroundColor = [UIColor whiteColor];
        //         self.dataSource = @[@"顺风快递",@"圆通快递",@"申通快递",@"韵达快递"];
        [self createView];
    }
    return self;
}

- (void)createView{
    self.topView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.topView];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=10; //设置每一行的间距
    layout.itemSize=CGSizeMake(kScreenWidth/5, 40);  //设置每个单元格的大小
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);

    
    _collection=[[UICollectionView alloc]initWithFrame:self.topView.bounds collectionViewLayout:layout];
    _collection.frame=self.topView.frame;
    self.collection.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.topView addSubview:self.collection];
    //注册cell单元格
    [self.collection registerClass:[RecreationCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    RecreationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    ClassificationModel *model = self.dataSource[indexPath.item];
    cell.nameLab.text = model.levelone_name;
    cell.nameLab.font = [UIFont systemFontOfSize:15];
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *Lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.topView.bounds.size.width, 40)];
        Lable.backgroundColor = [UIColor whiteColor];
        Lable.text = @"  选择分类";
        Lable.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:Lable];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){kScreenWidth,40};
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassificationModel *model = self.dataSource[indexPath.item];
    self.finishBlock(model.levelone_name);
}


@end
