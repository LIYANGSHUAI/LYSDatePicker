//
//  FifteenViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/7.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "FifteenViewController.h"

@interface FifteenViewController ()

@end

@implementation FifteenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LYSDatePicker *pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
    pickerView.datePickerMode = LYSDatePickerModeYearAndDateAndTime;
    pickerView.weekDayType = LYSDatePickerWeekDayTypeWeekdaySymbols;
    pickerView.hourStandard = LYSDatePickerStandard12Hour;
    pickerView.date = [NSDate date];
    
    LYSDateHeaderBarItem *cancelItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"取消" target:self action:@selector(cancelAction:)];
    
    cancelItem.tintColor = [UIColor whiteColor];
    
    LYSDateHeaderBarItem *commitItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"确定" target:self action:@selector(commitAction:)];
    
    commitItem.tintColor = [UIColor whiteColor];
    
    self.headerBar = [[LYSDateHeaderBar alloc] init];
    self.headerBar.rightBarItems = @[cancelItem,commitItem];
    self.headerBar.title = @"日期选择器";
    
    self.headerBar.titleColor = [UIColor whiteColor];
    
    pickerView.headerView.headerBar = self.headerBar;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    
}

- (void)cancelAction:(LYSDateHeaderBarItem *)sender
{
    NSLog(@"取消");
}

- (void)commitAction:(LYSDateHeaderBarItem *)sender
{
    NSLog(@"确定");
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
