//
//  SortView.m
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "SortView.h"
#import "FirstSortModel.h"
#import "SecondSortModel.h"
#import "ThirdSortModel.h"
#import "ETShopHelper.h"

@interface SortView () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSMutableArray *selectedArray;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) UIPickerView *pickView;
@property (nonatomic, strong) ETShopHelper *helper;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SortView
-(ETShopHelper *)helper{
    if (!_helper) {
        _helper = [ETShopHelper helper];
    }
    return _helper;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        [self getAddressInformation];
//        [self setBaseView];
        [self getSortData];
    }
    return self;
}

- (void)getAddressInformation {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sort" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
}

- (void) getSortData{
    [self.helper GetSortInfoWithType:@"0" success:^(NSArray *response) {
        if ([response isKindOfClass:[NSString class]]) {
            return ;
        }
        st_dispatch_async_main(^{
            NSMutableArray* dataArray = [[NSMutableArray alloc] init];
            self.dataArray = response;
            for (int i=0; i<response.count; i++) {
                
                FirstSortModel *model = [FirstSortModel mj_objectWithKeyValues:response[i]];
                [dataArray addObject:model.name];
            }
            self.provinceArray = dataArray;
            
            
            NSMutableArray* dataArray_2 = [[NSMutableArray alloc] init];

            FirstSortModel *model_2 = [FirstSortModel mj_objectWithKeyValues:response[0]];
            for (int i=0; i<model_2.childlist.count; i++) {
                
                SecondSortModel *model_3 = [SecondSortModel mj_objectWithKeyValues:model_2.childlist[i]];
                [dataArray_2 addObject:model_3.name];
            }
            self.cityArray = dataArray_2;
            
            NSMutableArray* dataArray_3 = [[NSMutableArray alloc] init];

            SecondSortModel *model_4 = [SecondSortModel mj_objectWithKeyValues:model_2.childlist[0]];
            for (int i=0; i<model_4.childlist.count; i++) {
                
                SecondSortModel *model_5 = [SecondSortModel mj_objectWithKeyValues:model_4.childlist[i]];
                [dataArray_3 addObject:model_5.name];
            }
            self.townArray = dataArray_3;
           [self setBaseView];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

- (void)setBaseView {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIColor *color = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    UIColor *btnColor = [UIColor colorWithRed:65.0/255 green:164.0/255 blue:249.0/255 alpha:1];
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 210, width, 30)];
    selectView.backgroundColor = color;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:btnColor forState:0];
    cancleBtn.frame = CGRectMake(0, 0, 60, 40);
    [cancleBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:btnColor forState:0];
    ensureBtn.frame = CGRectMake(width - 60, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(dateEnsureAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];
    [self addSubview:selectView];
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, height - 180 , width,  180)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = color;
    [self addSubview:self.pickView];
    [self.pickView reloadAllComponents];
    [self updateAddress];
    
}

- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town {
    self.province = province;
    self.city = city;
    self.town = town;
    if (self.province) {
        for (NSInteger i = 0; i < self.provinceArray.count; i++) {
            NSString *city = self.provinceArray[i];
            NSInteger select = 0;
            if ([city isEqualToString:self.province]) {
                select = i;
                [self.pickView selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
//        self.cityArray = [self.pickerDic[self.province][0] allKeys];
        for (NSInteger i = 0; i < self.cityArray.count; i++) {
            NSString *city = self.cityArray[i];
            if ([city isEqualToString:self.city]) {
                [self.pickView selectRow:i inComponent:1 animated:YES];
                break;
            }
        }
//        self.townArray = self.pickerDic[self.province][0][self.city];
        for (NSInteger i = 0; i < self.townArray.count; i++) {
            NSString *town = self.townArray[i];
            if ([town isEqualToString:self.town]) {
                [self.pickView selectRow:i inComponent:2 animated:YES];
                break;
            }
        }
    }
    [self.pickView reloadAllComponents];
    [self updateAddress];
}

- (void)dateCancleAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSAddressCancleAction:)]) {
        [self.delegate JSAddressCancleAction:@""];
    }
}

- (void)dateEnsureAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSAddressPickerRerurnBlockWithProvince:city:town:)]) {
        [self.delegate JSAddressPickerRerurnBlockWithProvince:self.province city:self.city town:self.town];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:self.font?:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        FirstSortModel *model = [FirstSortModel mj_objectWithKeyValues:self.dataArray[row]];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        for (int i = 0 ; i<model.childlist.count; i++) {
            
            SecondSortModel *secModel = model.childlist[i];
            [arr addObject:secModel.name];
        }
        self.cityArray = arr;
        
//        FirstSortModel *model = [FirstSortModel mj_objectWithKeyValues:self.dataArray[[pickerView selectedRowInComponent:0]]];
        
        SecondSortModel * secmodel = model.childlist[0];
        
        NSMutableArray *arr_2 = [[NSMutableArray alloc] init];
        
        for (int i = 0 ; i<secmodel.childlist.count; i++) {
            
            ThirdSortModel *thiModel = secmodel.childlist[i];
            [arr_2 addObject:thiModel.name];
        }
        self.townArray = arr_2;
        
        [self.selectedArray addObject:self.provinceArray[row]];
        
//        self.cityArray = model.childlist;
//        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
//        if (self.selectedArray.count > 0) {
//            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
//        } else {
//            self.cityArray = @[];
//        }
//        if (self.cityArray.count > 0) {
//            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
//        } else {
//            self.townArray = @[];
//        }
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    if (component == 1) {
        
        FirstSortModel *model = [FirstSortModel mj_objectWithKeyValues:self.dataArray[[pickerView selectedRowInComponent:0]]];
        
        SecondSortModel * secModel = model.childlist[row];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        for (int i = 0 ; i<secModel.childlist.count; i++) {
            
            ThirdSortModel *thiModel = secModel.childlist[i];
            [arr addObject:thiModel.name];
        }
        self.townArray = arr;
        
        [self.selectedArray addObject:self.cityArray[row]];
        
        
//        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:[self.pickView selectedRowInComponent:0]]];
//        NSDictionary *dic = self.selectedArray.firstObject;
//        NSString *stirng = self.cityArray[row];
//        for (NSString *string in dic.allKeys) {
//            if ([stirng isEqualToString:string]) {
//                self.townArray = dic[string];
//            }
//        }
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    if (component == 2) {
        
        [self.selectedArray addObject:self.townArray[row]];

        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    [self updateAddress];
}

- (void)updateAddress {
    self.province = [self.provinceArray objectAtIndex:[self.pickView selectedRowInComponent:0]];
    self.city  = [self.cityArray objectAtIndex:[self.pickView selectedRowInComponent:1]];
    self.town  = [self.townArray objectAtIndex:[self.pickView selectedRowInComponent:2]];
}

@end

