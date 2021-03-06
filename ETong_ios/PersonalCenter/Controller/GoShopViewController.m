//
//  GoShopViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "GoShopViewController.h"
#import "GoodShopCollectionViewCell.h"
#import "EveryDayHelper.h"
#import "ETGoodsDataModel.h"
#import "ETShopHelper.h"

@interface GoShopViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) UIImageView *headerImage;
@property(nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *shoucang;
@property (nonatomic, strong) NSString *strid;

@property (strong, nonatomic) EveryDayHelper *helper;
@property (nonatomic, strong) ETShopHelper *help;

@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation GoShopViewController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

-(ETShopHelper *)help{
    if (!_help) {
        _help = [ETShopHelper helper];
    }
    return _help;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    UISearchBar *view = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    view.userInteractionEnabled = false;
    self.navigationItem.titleView = view;
    
    [self addCollectionView];
    [self addLowView];
    [self getDate];
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
        [lowBtn addTarget:self action:@selector(clickLowButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:lowBtn];
    }
}

-(void)clickLowButton{
    ChetViewController *vc = [[ChetViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.receive_uid = self.dictionary[@"uid"];
    vc.title = self.dictionary[@"shopname"];
    if ([[ETUserInfo sharedETUserInfo].Id isEqualToString:self.dictionary[@"uid"]]) {
        [SVProgressHUD showErrorWithStatus:@"这是您自己的店铺，不能和自己聊天"];
        return;
    }
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先去登录"];
        return;
    }
    vc.navgationType = self.navgationType;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 获取商铺商品数据
-(void) getDate{
    
    [self.helper getGoodShopInfoWithShopid:self.dictionary[@"id"] Userid:self.dictionary[@"uid"] success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                ETGoodsDataModel *model = [ETGoodsDataModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
                
            }
            [self.collection reloadData];
            
        });
        NSLog(@"啦啦啦＝%@",self.dataArray[0][@"description"]);
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
    
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
    GoodShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ETGoodsDataModel *model = self.dataArray[indexPath.item];
    cell.nameLab.text = model.goodsname;
    cell.priceLab.text = [model.price stringByAppendingString:@"¥"];
    // 将string字符串转换为array数组
    NSArray  *array = [model.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    return cell;
}

// 跳转详情页
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ETGoodsDetailController *vc = [[ETGoodsDetailController alloc] initWithNibName:@"ETGoodsDetailController" bundle:nil];
    vc.goodModel = self.dataArray[indexPath.item];
    vc.goodModel.uid = self.dictionary[@"uid"];
    vc.hidesBottomBarWhenPushed = true;
    vc.navgationType = @"1";
    [self.navigationController pushViewController:vc animated:YES];
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
    headerImage.image=[UIImage imageNamed:@"ic_tejiakuang"];
    headerImage.userInteractionEnabled = YES;
    self.headerImage=headerImage;
    
    UIImageView *headImage=[[UIImageView alloc]init];
    headImage.contentMode=UIViewContentModeScaleAspectFill;
    headImage.clipsToBounds=YES;
    headImage.frame=CGRectMake(0, 35, 80, 80);
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,self.dictionary[@"photo"]];
    [headImage sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    [headerImage addSubview:headImage];
    
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(100, 50, 150, 20);
    name.text = self.dictionary[@"shopname"];
    name.textColor = [UIColor whiteColor];
    [headerImage addSubview:name];
    
    self.shoucang = [[UIButton alloc] init];
    self.shoucang.frame = CGRectMake(self.view.frame.size.width - 80, 40, 70, 30);
    self.shoucang.backgroundColor = [UIColor redColor];
    [self.shoucang setTitle:@"收藏" forState:UIControlStateNormal];
    [self.shoucang setTitle:@"已收藏" forState:UIControlStateSelected];
    self.shoucang.selected = NO;
    [headerImage addSubview:self.shoucang];
    [self.shoucang addTarget:self action:@selector(clickShoucangBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *collect = [[UILabel alloc] init];
    collect.frame = CGRectMake(self.view.frame.size.width - 120, 80, 110, 30);
    collect.textAlignment = NSTextAlignmentRight;
    collect.text = [NSString stringWithFormat:@"收藏:%@人",self.dictionary[@"businesslicense"]];
    collect.textColor = [UIColor whiteColor];
    collect.font = [UIFont systemFontOfSize:15];
    [headerImage addSubview:collect];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 160, self.view.frame.size.width, 40);
    btn.backgroundColor = [UIColor whiteColor];
    self.btn = btn;
    
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(15, 0, 150, 40);
    lable.text = @"全部宝贝";
    lable.textAlignment = NSTextAlignmentLeft;
    [btn addSubview:lable];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(self.view.frame.size.width - 35, 5, 20, 30);
    img.image = [UIImage imageNamed:@"ic_next-1"];
    [btn addSubview:img];
}


-(void)clickShoucangBtn{
    if (![ETUserInfo sharedETUserInfo].isLogin) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        return;
    }
    if (self.shoucang.selected) {
        [self.help cancleCollectionWithUserid:[ETUserInfo sharedETUserInfo].Id goodsid:self.dictionary[@"id"] type:@"2" success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                self.shoucang.selected = NO;
                [SVProgressHUD showSuccessWithStatus:@"取消收藏商铺成功"];
                
            });
            
        } faild:^(NSString *response, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏商铺失败"];
        }];
    }else{
        
        [self.help collectionGoodsWithUserid:[ETUserInfo sharedETUserInfo].Id goodsid:self.dictionary[@"id"] type:@"2" title:self.dictionary[@"shopname"] description:self.dictionary[@"description"] success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                self.shoucang.selected = YES;
                [SVProgressHUD showSuccessWithStatus:@"收藏商铺成功"];
                
            });
            
        } faild:^(NSString *response, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:@"收藏商铺失败"];
        }];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
