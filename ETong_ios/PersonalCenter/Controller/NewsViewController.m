//
//  NewsViewController.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "ETShopHelper.h"
#import "NewsModel.h"
#import "ChetViewController.h"

@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) ETShopHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation NewsViewController

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
    [self.helper getNewsListInfoWithUserid:[ETUserInfo sharedETUserInfo].Id success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<response.count; i++) {
                
                NewsModel *model = [NewsModel mj_objectWithKeyValues:response[i]];
                [self.dataArray addObject:model];
            }
            NSLog(@"%lu",(unsigned long)self.dataArray.count);
            NSLog(@"%@",[ETUserInfo sharedETUserInfo].Id);
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}


-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

/// 视图(tableView)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NewsModel *model = self.dataArray[indexPath.row];
    cell.nameLab.text = model.other_nickname;
    NSString *avatarUrlStr = [NSString stringWithFormat:@"%@/%@",kIMAGE_URL_HEAD,model.other_face];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrlStr] placeholderImage:[UIImage imageNamed:@"ic_xihuan"]];
    cell.contentLab.text = model.last_content;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChetViewController *vc = [[ChetViewController alloc] init];
    NewsModel *model = self.dataArray[indexPath.row];
    vc.receive_uid = model.chat_uid;
    vc.title = model.other_nickname;
    [self.navigationController pushViewController:vc animated:true];
}


@end
