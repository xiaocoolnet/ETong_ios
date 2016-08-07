//
//  ETMyZoneController.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETMyZoneController.h"
#import "ETMZoneCell.h"

@interface ETMyZoneController ()<UITabBarDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *bannerBtn;
@property (weak, nonatomic) IBOutlet UIButton *shaiWuBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;

@end

@implementation ETMyZoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _myTableView.estimatedRowHeight = 175;
    _myTableView.rowHeight = UITableViewAutomaticDimension;
    [_myTableView registerNib:[UINib nibWithNibName:@"ETMZoneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _myTableView.scrollEnabled = false;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_myTableView.contentSize.height > _myTableView.frame.size.height) {
        CGFloat changeHeight = _myTableView.contentSize.height-_myTableView.frame.size.height;
        _backViewHeight.constant +=changeHeight+50;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    ETMZoneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
