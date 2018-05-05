//
//  LYSDateLogicViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateLogicViewController.h"
#import "LYSDatePickerTypeDayAndTimeDelegate.h"
#import "LYSDatePickerTypeDayDelegate.h"
#import "LYSDatePickerTypeTimeDelegate.h"

@interface LYSDateLogicViewController ()

// 默认选择类型
@property (nonatomic,strong)LYSDatePickerTypeBase *typeBase;

@end

@implementation LYSDateLogicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认开始年份
        self.fromYear = 1970;
        // 默认结束年份
        self.toYear = 2070;
        // 默认选择器类型
        self.pickType = LYSDatePickerTypeDayAndTime;
        // 默认选中日期
        self.selectDate = [NSDate date];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化选择器类型
    [self initPickerType];
    
    // 设置默认日期
    [self.typeBase defaultWithDate:self.selectDate];
    [self.typeBase updateDatePicker];
}


// 初始化选择器类型
- (void)initPickerType
{
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
            self.typeBase = [[LYSDatePickerTypeDayAndTimeDelegate alloc] init];
        }
            break;
        case LYSDatePickerTypeDay:
        {
            self.typeBase = [[LYSDatePickerTypeDayDelegate alloc] init];
        }
            break;
        case LYSDatePickerTypeTime:
        {
            self.typeBase = [[LYSDatePickerTypeTimeDelegate alloc] init];
        }
            break;
        default:
            break;
    }
    
    self.typeBase.view = self.view;
    self.typeBase.pickView = self.pickView;
    self.typeBase.fromYear = self.fromYear;
    self.typeBase.toYear = self.toYear;
    
    self.pickView.delegate = self.typeBase;
    self.pickView.dataSource = self.typeBase;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
