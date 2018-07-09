//
//  SevenViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/7.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "SevenViewController.h"

@interface SevenViewController ()

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LYSDatePicker *pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
    pickerView.datePickerMode = LYSDatePickerModeDate;
    pickerView.weekDayType = LYSDatePickerWeekDayTypeCustom;
    pickerView.date = [NSDate date];
    pickerView.weekDayArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"开始时间",@"结束时间"]];
    control.frame = CGRectMake(0, 0, 100, 30);
    control.tintColor = [UIColor whiteColor];
    control.selectedSegmentIndex = 0;
    
    [control addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventValueChanged)];
    
    self.headerBar.titleView = control;
    
    
    pickerView.headerView.headerBar = self.headerBar;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    
}

- (void)clickAction:(UISegmentedControl *)sender
{
    NSLog(@"选择");
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
