//
//  SearchViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIView *aview;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];

    self.navigationItem.hidesBackButton = YES;//可以隐藏原有的导航栏返回按钮
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 40, 30);
    [self.leftBtn setTitle:@"宝贝" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = item3;
    
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn1 setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
   
    self.navigationItem.rightBarButtonItem = item1;
    self.navigationItem.leftBarButtonItem = item3;

    
    [self addSearchBar];
}

-(void)rightNavBtnAction{
    [self.searchbar resignFirstResponder];
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addSearchBar{
    self.searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.layer.cornerRadius=5;
    _searchbar.layer.masksToBounds=true;
    _searchbar.placeholder = @"请输入相关信息";
    self.searchbar.tintColor = [UIColor whiteColor];
    UITextField *textFieldInsideSearchBar = [_searchbar valueForKey:@"searchField"];
    textFieldInsideSearchBar.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    UILabel *textFieldInsideSearchBarLabel = [textFieldInsideSearchBar valueForKey:@"placeholderLabel"];
    
    textFieldInsideSearchBarLabel.textColor= [UIColor whiteColor];
    _searchbar.keyboardType=UIKeyboardTypeDefault;
    _searchbar.delegate=self;
    self.navigationItem.titleView = self.searchbar;
}

-(void)leftNavBtnAction{
    self.aview = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 60, 80)];
    self.aview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.aview];
    NSArray *arr = @[@"宝贝",@"店铺"];
    for (int i = 0; i < 2; i++) {
        UIButton *typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*40, 60, 40)];
        [typeBtn setTitle:arr[i] forState:UIControlStateNormal];
        typeBtn.tag = 1000 + i;
        [self.aview addSubview:typeBtn];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [typeBtn addTarget:self action:@selector(clickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickTypeBtn:(UIButton *)btn{
    if (btn.tag == 1000) {
        [self.leftBtn setTitle:@"宝贝" forState:UIControlStateNormal];
        
    }else{
        [self.leftBtn setTitle:@"店铺" forState:UIControlStateNormal];
    }
    self.aview.hidden = YES;
    [self.aview removeFromSuperview];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SearchResultViewController *vc = [[SearchResultViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    vc.str = searchBar.text;
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
