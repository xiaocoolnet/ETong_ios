//
//  ClassificationViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ClassificationViewController.h"
#import "SortCollectionViewCell.h"
#import "EveryDayHelper.h"
#import "ClassificationModel.h"

@interface ClassificationViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UISearchBar *searchbar;
@property (strong, nonatomic) EveryDayHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ClassificationViewController

-(EveryDayHelper *)helper{
    if (!_helper) {
        _helper = [EveryDayHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSearchBar];
    [self addTableView];
    [self addCollectionView];
    [self GetSecondData];
}
#pragma mark - 添加搜索栏
-(void)addSearchBar{
    self.searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.layer.cornerRadius=5;
    _searchbar.layer.masksToBounds=true;
    _searchbar.placeholder = self.nameStr;
    self.searchbar.tintColor = [UIColor whiteColor];
    UITextField *textFieldInsideSearchBar = [_searchbar valueForKey:@"searchField"];
    textFieldInsideSearchBar.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    UILabel *textFieldInsideSearchBarLabel = [textFieldInsideSearchBar valueForKey:@"placeholderLabel"];
    
    textFieldInsideSearchBarLabel.textColor= [UIColor whiteColor];
    _searchbar.keyboardType=UIKeyboardTypeDefault;
    _searchbar.delegate=self;
    self.searchbar.userInteractionEnabled = NO;
    self.navigationItem.titleView = self.searchbar;
}

#pragma mark - 添加左侧分类TableView
-(void) addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - 添加右侧分类CollectionView
-(void)addCollectionView{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=5; //设置每一行的间距
    layout.itemSize=CGSizeMake((kScreenWidth-100)/3 - 10, 110);  //设置每个单元格的大小
    layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    
    _collection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.frame=CGRectMake(100, 0, Screen_frame.size.width - 100, Screen_frame.size.height - 64);
    //注册cell单元格
    [self.collection registerClass:[SortCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collection.delegate=self;
    _collection.dataSource=self;
    _collection.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self.view addSubview:_collection];
}

#pragma - mark - 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    ClassificationModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.leveltwo_name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassificationModel *model = self.dataSource[indexPath.item];
    [self GetThirdData:model.leveltwo_name];
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
    SortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ClassificationModel *model = self.dataArray[indexPath.item];
    cell.nameLab.text = model.levelthree_name;
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,model.pic];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SortGoodViewController *vc = [[SortGoodViewController alloc] init];
    ClassificationModel *model = self.dataArray[indexPath.item];
    vc.hidesBottomBarWhenPushed = YES;
    vc.str = model.levelthree_name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取左侧分类数据
-(void)GetSecondData{
    [self.helper getSecondGoodsListInfoWithName:self.nameStr success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataSource = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                ClassificationModel *model = [ClassificationModel mj_objectWithKeyValues:response[i]];
                [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

#pragma mark - 获取右侧三级列表数据
-(void)GetThirdData:(NSString *)name{
    [self.helper getSecondGoodsListInfoWithname:name success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                ClassificationModel *model = [ClassificationModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
            }
            [self.collection reloadData];
        });
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

@end
