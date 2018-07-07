//
//  NineViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/6.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "NineViewController.h"

@interface NineViewController ()

@end

@implementation NineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LYSDatePicker *pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
    pickerView.datePickerMode = LYSDatePickerModeDateAndTime;
    pickerView.weekDayType = LYSDatePickerWeekDayTypeWeekdaySymbols;
    pickerView.date = [NSDate date];
    pickerView.headerView.headerBar = self.headerBar;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    
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
