//
//  SellerEvaluateViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SellerEvaluateViewController.h"
#import "EvaluateTableViewCell.h"
#import "ETShopHelper.h"
#import "EvaluateModel.h"

@interface SellerEvaluateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) ETShopHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation SellerEvaluateViewController

-(ETShopHelper *)helper{
    if (!_helper) {
        _helper = [ETShopHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [self addTableView];
    [self Getdata];
}


-(void)Getdata{
    [self.helper getEvaluateListInfoWithUserid:[ETUserInfo sharedETUserInfo].Id Type:@"2" success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<response.count; i++) {
                
                EvaluateModel *model = [EvaluateModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
            }
            NSLog(@"%lu",(unsigned long)self.dataArray.count);
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}


-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64 - 44) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[EvaluateTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EvaluateModel *model = self.dataArray[indexPath.row];
    cell.nameLab.text = model.goods_info.firstObject.goodsname;
    // 将string字符串转换为array数组
    NSArray  *array = [model.goods_info.firstObject.picture componentsSeparatedByString:@","]; //--分隔符
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,array.firstObject];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    cell.contentLab.text = model.content;
    
    return cell;
}

@end
