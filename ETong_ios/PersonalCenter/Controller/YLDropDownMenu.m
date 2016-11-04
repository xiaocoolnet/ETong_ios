//
//  YLDropDownMenu.m
//  YLDrowDownMenu
//
//  Created by Bing on 16/6/29.
//  Copyright © 2016年 Yang. All rights reserved.
//

#import "YLDropDownMenu.h"

@interface YLDropDownMenu()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *mytableView;

@end

@implementation YLDropDownMenu


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
    
    self.mytableView = [[UITableView alloc] initWithFrame:self.topView.bounds style:UITableViewStylePlain];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    [self.topView addSubview:self.mytableView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)self.dataSource.count);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    self.finishBlock(self.dataSource[indexPath.row]);
    self.finishRow(stringInt);
}


@end
