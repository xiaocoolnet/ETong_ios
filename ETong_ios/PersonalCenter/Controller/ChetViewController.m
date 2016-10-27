//
//  ViewController.m
//  QQ自动回复
//
//  Created by 冷求慧 on 15/12/7.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import "ChetViewController.h"
#import "messModel.h"
#import "modelFrame.h"
#import "CustomTableViewCell.h"
#import "ETShopHelper.h"
#import <AFNetworking/AFNetworking.h>
#import <UIKit/UIKit.h>


#define HEIGHTS [UIScreen mainScreen].bounds.size.height
#define WIDTHS [UIScreen mainScreen].bounds.size.width
@interface ChetViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property (nonatomic,strong)UITextField *inputMess;
@property (nonatomic,strong)UIButton *senderButton;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)NSMutableArray *arrModelData;
@property (nonatomic,assign)CGFloat boreadHight;
@property (nonatomic,assign)CGFloat moveTime;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,assign)NSTimer *timer;
@property (nonatomic,assign)NSInteger num;
@property (strong, nonatomic) ETShopHelper *helper;

@end
@implementation ChetViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_customTableView reloadData];
    
}
-(ETShopHelper *)helper{
    if (!_helper) {
        _helper = [ETShopHelper helper];
    }
    return _helper;
}


-(NSMutableArray *)arrModelData{
    if (_arrModelData==nil) {
        _arrModelData=[NSMutableArray array];
    }
    return _arrModelData;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self someSet];
    
   
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
    
    NSDate *nowdate=[NSDate date];
    NSDateFormatter *forMatter=[[NSDateFormatter alloc]init];
    forMatter.dateFormat=@"HH:mm"; //小时和分钟
    NSString *nowTime=[forMatter stringFromDate:nowdate];
    NSLog(@"slsls = %@",self.receive_uid);
    [self.helper GetTalkNewsWithUserid:[ETUserInfo sharedETUserInfo].Id Receive_uid:self.receive_uid success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            self.arrModelData = [[NSMutableArray alloc] init];
            self.dataSource = [[NSArray alloc] init];
            self.dataSource = response;
            
            for (int i=0; i<response.count; i++) {
               
                NSMutableDictionary *dicValues=[NSMutableDictionary dictionary];
                dicValues[@"desc"]=[NSString stringWithFormat:@"%@",[response[i] objectForKey:@"content"]];
                dicValues[@"time"]=[response[i] objectForKey:@"time"];
                
                if ([[NSString stringWithFormat:@"%@",[response[i] objectForKey:@"send_uid"]] isEqualToString:[ETUserInfo sharedETUserInfo].Id]){
                    dicValues[@"imageName"]=@"girl";
                    dicValues[@"person"]=[NSNumber numberWithBool:1];
                    //                mess.person = YES;
                }else{
                    dicValues[@"imageName"]=@"boy";
                    dicValues[@"person"]=[NSNumber numberWithBool:0];
                    //                mess.person = NO;
                }
                NSLog(@"%@",[NSString stringWithFormat:@"%@",[response[i] objectForKey:@"time"]]);
                if ([[NSString stringWithFormat:@"%@",[response[i] objectForKey:@"time"]] isEqualToString:@"(null)"]) {
                    NSLog(@"%@",dicValues);
                    messModel *mess=[[messModel alloc]initWithModel:dicValues];
                    modelFrame *frameModel=[modelFrame modelFrame:mess timeIsEqual:YES];
                    //            frameModel.myself = YES;
                    [self.arrModelData addObject:frameModel];
                }else{
                    NSLog(@"%@",dicValues);
                    messModel *mess=[[messModel alloc]initWithModel:dicValues];
                    modelFrame *frameModel=[modelFrame modelFrame:mess timeIsEqual:[self timeIsEqual:nowTime]];
                    //            frameModel.myself = YES;
                    [self.arrModelData addObject:frameModel];
                }
                
            }
            NSLog(@"%lu",(unsigned long)self.arrModelData.count);
//            NSLog(@"%@",response[1]);
            [self.customTableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
    
    //        [self.customTableView reloadData];
    NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
    [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    _num=0;
    if ([self.navgationType isEqualToString:@"1"]) {
        self.customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44) style:UITableViewStylePlain];
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0,HEIGHTS- 44, WIDTHS, 44)];
    }else{
        self.customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44-64) style:UITableViewStylePlain];
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0,HEIGHTS- 44 - 64, WIDTHS, 44)];
    }

    self.customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    [self.view addSubview:self.customTableView];
    self.senderButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTHS- 40 , 5, 40, 34)];

    self.senderButton.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:196.0 / 255.0 blue:171.0 / 255.0 alpha:1];
    [self.senderButton setImage:[UIImage imageNamed:@"servicesS"] forState:UIControlStateNormal];
    [self.senderButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    self.bgView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:196.0 / 255.0 blue:171.0 / 255.0 alpha:1];
    [self.bgView addSubview:self.inputMess];
    [self.bgView addSubview:self.senderButton];
    [self.view addSubview:self.bgView];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timego) userInfo:nil repeats:YES];
    
    // 监听键盘出现的出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
     if  (self.dataSource != nil){
         
         NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
         [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];

     }
    
    
}

#pragma mark - timego

-(void)timego{
    if (_num==2) {
        [_timer invalidate];
    }
    _num++;
    [_customTableView reloadData];
}

#pragma mark - set

-(UITextField*)inputMess{
    
    if (!_inputMess) {
        _inputMess = [[UITextField alloc]initWithFrame:CGRectMake(8, 6, WIDTHS-35-20, 32)];
        _inputMess.layer.masksToBounds = YES;
        _inputMess.backgroundColor = [UIColor whiteColor];
        _inputMess.layer.cornerRadius = 5;
        _inputMess.layer.borderColor = [UIColor grayColor].CGColor;
        _inputMess.layer.borderWidth = 1;
        _inputMess.font = [UIFont systemFontOfSize:12];
        _inputMess.placeholder = @"说点什么吧...";
        
    }
    
    return _inputMess;
}
#pragma mark 一Action

- (void)sendAction:(UIButton *)sender {
 
    [self.helper SendTalkNewsWithUserid:[ETUserInfo sharedETUserInfo].Id Receive_uid:self.receive_uid Content:_inputMess.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
//            [SVProgressHUD showSuccessWithStatus:@"消息发送成功"];
            
        });
        
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"消息发送失败"];
    }];
    [self sendMess:self.inputMess.text]; //发送信息
}


#pragma mark 一些UI设置
-(void)someSet{
    self.inputMess.delegate=self;//设置UITextField的代理
    self.inputMess.returnKeyType=UIReturnKeySend;//更改返回键的文字 (或者在sroryBoard中的,选中UITextField,对return key更改)
    self.inputMess.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:222.0/255.0f green:222.0/255.0f blue:221.0/255.0f alpha:1.0f]];
    self.customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [bgView setBackgroundColor:[UIColor colorWithRed:222.0/255.0f green:222.0/255.0f blue:221.0/255.0f alpha:1.0f]];
    [self.customTableView setBackgroundView:bgView];
    [self.customTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.customTableView setShowsVerticalScrollIndicator:NO];
}

#pragma mark  -TableView的DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrModelData.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    modelFrame *frameModel=self.arrModelData[indexPath.row];
    
    return frameModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strId=@"cellId";
    CustomTableViewCell *customCell=[tableView dequeueReusableCellWithIdentifier:strId];
    if (customCell == nil){
        customCell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
        if (self.dataSource.count>0 && self.dataSource[0][@"send_face"] != nil) {
            customCell.selfPhoto = self.dataSource[0][@"send_face"];
        }
        if (self.dataSource.count>0 && self.dataSource[0][@"receive_face"] != nil) {
            customCell.otherPhoto = self.dataSource[0][@"receive_face"];
        }
        if (self.dataSource.count==0 || self.dataSource[0][@"send_face"] == nil) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"photo"] != nil) {
                NSUserDefaults *photo = [[NSUserDefaults standardUserDefaults] objectForKey:@"photo"];
                NSString *url = [NSString stringWithFormat:@"%@",photo];
                customCell.selfPhoto = url;
            }
            
        }
    }


    [customCell setBackgroundColor:[UIColor whiteColor]];
    customCell.selectionStyle=UITableViewCellSelectionStyleNone;
    customCell.frameModel=self.arrModelData[indexPath.row];
    return customCell;
}

#pragma mark 键盘将要出现
-(void)keyboardWillShow:(NSNotification *)notifa{
    [self dealKeyboardFrame:notifa];
}
#pragma mark 键盘消失完毕
-(void)keyboardWillHide:(NSNotification *)notifa{
    [self dealKeyboardFrame:notifa];
}
#pragma mark 处理键盘的位置
-(void)dealKeyboardFrame:(NSNotification *)changeMess{
    NSDictionary *dicMess=changeMess.userInfo;//键盘改变的所有信息
    CGFloat changeTime=[dicMess[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];//通过userInfo 这个字典得到对得到相应的信息//0.25秒后消失键盘
    CGFloat keyboardMoveY=[dicMess[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y-[UIScreen mainScreen].bounds.size.height;//键盘Y值的改变(字典里面的键UIKeyboardFrameEndUserInfoKey对应的值-屏幕自己的高度)
    self.boreadHight = keyboardMoveY;
    NSLog(@"%f",keyboardMoveY);
    
    self.moveTime = changeTime;
    CGFloat hightCount = 0.0;
    for (modelFrame *frameModel in self.arrModelData) {
        hightCount = hightCount + frameModel.cellHeight;
    }
    NSLog(@"%f",hightCount);
    
    [UIView animateWithDuration:changeTime animations:^{ //0.25秒之后改变tableView和bgView的Y轴
        self.bgView.transform=CGAffineTransformMakeTranslation(0, keyboardMoveY);
        self.customTableView.transform=CGAffineTransformMakeTranslation(0, keyboardMoveY);
    }];
    
    
    if (hightCount>(HEIGHTS-64+keyboardMoveY)) {
        [UIView animateWithDuration:changeTime animations:^{ //0.25秒之后改变tableView和bgView的Y轴
            self.customTableView.transform=CGAffineTransformMakeTranslation(0, keyboardMoveY);
           
            
        }];
        NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
        [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];//将tableView的行滚到最下面的一行
    }
    
}
#pragma mark 滚动TableView去除键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.inputMess resignFirstResponder];
}
#pragma mark TextField的Delegate send后的操作
- (BOOL)textFieldShouldReturn:(UITextField *)textField{  //
    [self.helper SendTalkNewsWithUserid:[ETUserInfo sharedETUserInfo].Id Receive_uid:self.receive_uid Content:_inputMess.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"消息发送成功"];
            
        });
        
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"消息发送失败"];
    }];
    
    [self sendMess:self.inputMess.text]; //发送信息
    [self.customTableView reloadData];
    return YES;
}

#pragma mark 发送消息,刷新数据
-(void)sendMess:(NSString *)messValues{
    //添加一个数据模型(并且刷新表)
    //获取当前的时间
    NSDate *nowdate=[NSDate date];
    NSDateFormatter *forMatter=[[NSDateFormatter alloc]init];
    forMatter.dateFormat=@"HH:mm"; //小时和分钟
    NSString *nowTime=[forMatter stringFromDate:nowdate];
    NSMutableDictionary *dicValues=[NSMutableDictionary dictionary];
    
//    dicValues[@"imageName"]=@"girl";
    dicValues[@"desc"]=messValues;
    dicValues[@"time"]=nowTime; //当前的时间
    dicValues[@"person"]=[NSNumber numberWithBool:1]; //转为Bool类型
    messModel *mess=[[messModel alloc]initWithModel:dicValues];
    modelFrame *frameModel=[modelFrame modelFrame:mess timeIsEqual:[self timeIsEqual:nowTime]]; //判断前后时候是否一致
    frameModel.myself = YES;
    [self.arrModelData addObject:frameModel];
    [self.customTableView reloadData];
    
    self.inputMess.text=nil;
    
    //自动回复就是再次添加一个frame模型
//    NSArray *arrayAutoData=@[@"蒸桑拿蒸馒头不争名利，弹吉它弹棉花不谈感情",@"女人因为成熟而沧桑，男人因为沧桑而成熟",@"男人善于花言巧语，女人喜欢花前月下",@"笨男人要结婚，笨女人要减肥",@"爱与恨都是寂寞的空气,哭与笑表达同样的意义",@"男人的痛苦从结婚开始，女人的痛苦从认识男人开始",@"女人喜欢的男人越成熟越好，男人喜欢的女孩越单纯越好。",@"做男人无能会使女人寄希望于未来，做女人失败会使男人寄思念于过去",@"我很优秀的，一个优秀的男人，不需要华丽的外表，不需要有渊博的知识，不需要有沉重的钱袋",@"世间纷繁万般无奈，心头只求片刻安宁"];
    //添加自动回复的
//    int num= arc4random() %(arrayAutoData.count); //获取数组中的随机数(数组的下标)
//    
//    
//    //    NSLog(@"得到的时间是:%@",nowdate);
//    NSMutableDictionary *dicAuto=[NSMutableDictionary dictionary];
//    dicAuto[@"imageName"]=@"boy";
//    dicAuto[@"desc"]=[arrayAutoData objectAtIndex:num];
//    dicAuto[@"time"]=nowTime;
//    dicAuto[@"person"]=[NSNumber numberWithBool:0]; //转为Bool类型
//    messModel *messAuto=[[messModel alloc]initWithModel:dicAuto];
//    modelFrame *frameModelAuto=[modelFrame modelFrame:messAuto timeIsEqual:[self timeIsEqual:nowTime]];//判断前后时候是否一致
//    [self.arrModelData addObject:frameModelAuto];
//    [self.customTableView reloadData];
    
    CGFloat hightCount = 0.0;
    for (modelFrame *frameModel in self.arrModelData) {
        hightCount = hightCount + frameModel.cellHeight;
    }
    if (hightCount>HEIGHTS-64+self.boreadHight) {
        [UIView animateWithDuration:self.moveTime animations:^{ //0.25秒之后改变tableView和bgView的Y轴
            self.customTableView.transform=CGAffineTransformMakeTranslation(0, self.boreadHight);
            
            
        }];
        NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
        [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];//将tableView的行滚到最下面的一行
    }
    
    NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrModelData.count-1 inSection:0];
    [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark 判断前后时间是否一致
-(BOOL)timeIsEqual:(NSString *)comStrTime{
    modelFrame *frame=[self.arrModelData lastObject];
    NSString *strTime=frame.dataModel.time; //frame模型里面的NSString时间
    if ([strTime isEqualToString:comStrTime]) { //比较2个时间是否相等
        return YES;
    }
    return NO;
}
@end
